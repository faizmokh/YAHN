import Foundation
import Combine
import SwiftUI
import TimelaneCombine

struct API {

    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "hn-api", qos: .default, attributes: .concurrent)

    enum EndPoint {
        static let baseURL = URL(string: "https://hacker-news.firebaseio.com/v0/")!

        case topStories
        case story(Int)
        case comment(Int)

        var url: URL {
            switch self {
            case .topStories:
                return EndPoint.baseURL.appendingPathComponent("topstories.json")
            case .story(let id):
                return EndPoint.baseURL.appendingPathComponent("item/\(id).json")
            case .comment(let id):
                return EndPoint.baseURL.appendingPathComponent("item/\(id).json")
            }
        }
    }

    func topStories() -> AnyPublisher<[Story], Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.topStories.url)
            .map { $0.0 }
            .decode(type: [Int].self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.topStories.url)
                default:
                    return Error.invalidResponse
                }
        }
        .filter { !$0.isEmpty }
        .flatMap { storyIDs in
            return self.mergedStories(ids: storyIDs)
        }
        .scan([], { (stories, story) -> [Story] in
            return stories + [story]
        })
        .eraseToAnyPublisher()
    }

    func mergedStories(ids storyIDs: [Int]) -> AnyPublisher<Story, Error> {
        let storyIDs = Array(storyIDs.prefix(20))

        precondition(!storyIDs.isEmpty)

        let initialPublisher = story(id: storyIDs[0])
        let remainder = Array(storyIDs.dropFirst())

        return remainder.reduce(initialPublisher) { (combined, id) -> AnyPublisher<Story, Error> in
            return combined.merge(with: story(id: id))
                .eraseToAnyPublisher()
        }
    }

    func comments(parentID: [Int]) -> AnyPublisher<Comment, Error> {

        let initialPublisher = comment(id: parentID[0])

        return parentID.reduce(initialPublisher) { (combined, id) -> AnyPublisher<Comment, Error> in
            return combined.merge(with: comment(id: id))
            .eraseToAnyPublisher()
        }
    }

    func story(id: Int) -> AnyPublisher<Story, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.story(id).url)
            .receive(on: apiQueue)
            .map { $0.0 }
            .decode(type: Story.self, decoder: decoder)
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }

    func comment(id: Int) -> AnyPublisher<Comment, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.comment(id).url)
            .print("comment \(id):")
            .receive(on: apiQueue)
            .map{ $0.0 }
            .decode(type: Comment.self, decoder: decoder)
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
}

extension API {
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }

        case addressUnreachable(URL)
        case invalidResponse

        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "The server responded with garbage."
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
            }
        }
    }
}

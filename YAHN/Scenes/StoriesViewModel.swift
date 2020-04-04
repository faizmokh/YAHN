import Foundation
import Combine
import SwiftUI

class StoriesViewModel: ObservableObject {
    private let api = API()
    private var topStories = [Story]()
    @Published var error: API.Error? = nil

    var stories: [Story] {
        return topStories
    }

    @Published private var subscriptions = Set<AnyCancellable>()

    func fetchStories() {
        api.topStories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { stories in
                self.topStories = stories
            })
            .store(in: &subscriptions)
    }
}

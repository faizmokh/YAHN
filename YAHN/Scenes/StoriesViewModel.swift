import Foundation
import Combine
import SwiftUI

class StoriesViewModel: ObservableObject {
    private let api = API()

    @Published var stories: [Story] = [Story]()
    @Published var error: API.Error? = nil


    @Published private var subscriptions = Set<AnyCancellable>()

    func fetchStories() {
        api.topStories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { stories in
                self.stories = stories
            })
            .store(in: &subscriptions)
    }
}

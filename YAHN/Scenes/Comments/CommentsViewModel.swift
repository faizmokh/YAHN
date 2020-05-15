import Foundation
import Combine

class CommentsViewModel {

    var title: String {
        story.title
    }

    var author: String {
        story.by
    }

    var comments: String {
        "\(story.descendants) comments"
    }

    var child: [Int] {
        story.kids
    }

    private let story: Story
    private let api = API()
    private var subscriptions = Set<AnyCancellable>()

    init(story: Story) {
        self.story = story
    }

    func fetchComments() {
        api.comments(parentID: story.kids)
            .print()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in

            }, receiveValue: { comments in
                print(comments)
            })
            .store(in: &subscriptions)

    }
}

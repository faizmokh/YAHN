import Foundation
import Combine

class CommentsViewModel: ObservableObject {

    var title: String {
        story.title
    }

    var author: String {
        story.by
    }

    var commentsCount: String {
        "\(story.descendants) comments"
    }

    @Published var comments: [Comment]

    var child: [Int] {
        story.kids
    }

    private let story: Story
    private let api = API()
    private var subscriptions = Set<AnyCancellable>()

    init(story: Story) {
        self.story = story
        self.comments = [Comment]()
    }

    func fetchComments() {
        api.comments(parentID: story.kids)
            .print()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in

            }, receiveValue: { comments in
                self.comments.append(comments)
            })
            .store(in: &subscriptions)

    }
}

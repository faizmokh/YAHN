import Foundation

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

    init(story: Story) {
        self.story = story
    }
}

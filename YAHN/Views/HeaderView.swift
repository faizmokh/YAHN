import SwiftUI

struct HeaderView: View {

    let title: String
    let author: String
    let comments: String

    init(title: String, author: String, comments: String) {
        self.title = title
        self.author = author
        self.comments = comments
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            HStack {
                Image(systemName: "person.fill")
                Text(author)
                    .fontWeight(.regular)
                Image(systemName: "bubble.left.and.bubble.right")
                Text(comments)
                    .fontWeight(.regular)
            }
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Ask HN: How can you create an app with SwiftUI?", author: "faizmokhtar", comments: "392 comments")
            .previewLayout(.sizeThatFits)
    }
}

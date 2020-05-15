import SwiftUI

struct CommentView: View {
    let comment: Comment

    init(comment: Comment) {
        self.comment = comment
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                Text(comment.by)
                    .fontWeight(.semibold)
                Image(systemName: "clock.fill")
                    .padding(.leading, 5)
                Text(CommentView.formatter.string(from: Date(timeIntervalSince1970: comment.time)))
                    .fontWeight(.semibold)
            }
            .font(.footnote)
            .foregroundColor(.accentColor)
            Text(comment.text)
                .font(.body)
        }
    .padding()
    }

    private static var formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .none
        f.timeStyle = .short
        return f
    }()
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(id: 1, by: "faizmokhtar", kids: [], parent: 100, text: "I prefer to use a SQLite database. And if a customer insists on CSV then I still use a SQLite database to import", time: 1586270677, type: "comments")
          )
            .previewLayout(.sizeThatFits)
    }
}

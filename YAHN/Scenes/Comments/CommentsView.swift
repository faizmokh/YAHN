import SwiftUI

struct CommentsView: View {

    let viewModel: CommentsViewModel

    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            Section(header: HeaderView(title: viewModel.title, author: viewModel.author, comments: viewModel.comments)) {
                ForEach(viewModel.child, id: \.self) { c in
                    Text("id \(c)")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text(viewModel.comments), displayMode: .inline)
        .onAppear(perform: viewModel.fetchComments)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static let story = Story(id: 1, by: "tom", descendants: 30, kids: [], score: 300, time: 1175714200, title: "This is a title", type: "stories", url: "testing.com")
    static var previews: some View {
        CommentsView(viewModel: CommentsViewModel(story: story))
    }
}

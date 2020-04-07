import SwiftUI

struct StoriesView: View {

    @ObservedObject var viewModel: StoriesViewModel

    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.stories) { story in
                    NavigationLink(destination: CommentsView(viewModel: CommentsViewModel(story: story))) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(story.title)
                                .font(.headline)
                                .fontWeight(.semibold)
                            if self.getHostDomain(url: story.url) != nil {
                                Text(self.getHostDomain(url: story.url) ?? "")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                            }
                            Text("\(story.score) points by \(story.by) | \(story.descendants) comments")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    }
                }
            }
            .navigationBarTitle(Text("Top Stories"))
        }
        .onAppear(perform: viewModel.fetchStories)
    }

    private func getHostDomain(url: String) -> String? {
        guard let url = URL(string: url),
            let host = url.host else {
                return nil
        }
        return host
    }
}

struct StoriesView_Previews: PreviewProvider {
    static let viewModel = StoriesViewModel(stories: stories)
    static var previews: some View {
        Group {
            StoriesView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
            StoriesView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8 Dark")
                .environment(\.colorScheme, .dark)
            StoriesView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
        }
    }

    static let stories = [
        Story(id: 1, by: "tom", descendants: 30, kids: [], score: 300, time: 1175714200, title: "This is a title", type: "stories", url: "testing.com"),
        Story(id: 1, by: "faiz", descendants: 30, kids: [], score: 300, time: 1175714200, title: "This is a second title", type: "stories", url: "testing.com")
    ]
}

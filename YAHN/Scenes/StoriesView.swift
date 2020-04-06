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
                    VStack(alignment: .leading, spacing: 10) {
                        Text(story.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("\(story.score) points by \(story.by) | \(story.descendants) comments")
                            .font(.footnote)
                            .fontWeight(.regular)
                    }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
            }
            .navigationBarTitle(Text("Top Stories"))
        }
        .onAppear(perform: viewModel.fetchStories)
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(viewModel: StoriesViewModel())
    }
}

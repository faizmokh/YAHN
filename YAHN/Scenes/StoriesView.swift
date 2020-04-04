import SwiftUI

struct StoriesView: View {

    @ObservedObject var viewModel: StoriesViewModel

    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(self.viewModel.stories) { story in
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .frame(minHeight: 0, maxHeight: 100)
                        .font(.title)
                    Button(story.url) {
                        print(story)
                    }
                    .font(.subheadline)
                    .foregroundColor(Color.blue)
                    .padding(.top, 6)
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("Top Stories"))
        .onAppear(perform: viewModel.fetchStories)
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(viewModel: StoriesViewModel())
    }
}

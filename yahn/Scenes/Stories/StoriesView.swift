//
//  StoriesView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct StoriesView: View {

    @ObservedObject var viewModel: StoriesViewModel

    @State var isPresented: Bool = false

    private var selected: Int

    init(viewModel: StoriesViewModel, selected: Int = 0) {
        self.viewModel = viewModel
        self.selected = selected
    }

    var body: some View {
        List {
            ForEach(viewModel.stories) { story in
                if story.type != .jobs {
                    NavigationLink(destination:
                    CommentsView(viewModel: CommentsViewModel(story: story))) {
                        StoryView(story: story)
                    }
                } else if story.url != nil {
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        StoryView(story: story)
                    }.sheet(isPresented: self.$isPresented) {
                        SafariView(url: story.url!)
                    }
                }
            }
            Button(action: viewModel.loadMore) {
                GeometryReader { reader in
                    HStack(alignment: .center) {
                        Text("Load more")
                            .font(.callout)
                            .fontWeight(.heavy)
                    }
                    .frame(width: reader.size.width, height: 50, alignment: .center)
                }
                .padding(.vertical, 25)
            }
            .buttonStyle(SecondaryButtonStyle())
        }.listStyle(PlainListStyle())
        .onAppear(perform: {
            self.viewModel.fetchStories()
        })
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(viewModel: StoriesViewModel(worker: HNWorker()))
    }
}

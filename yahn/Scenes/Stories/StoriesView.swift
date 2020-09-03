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

    private let loadingPlaceholders = Array(repeating: staticStory, count: 10)

    init(viewModel: StoriesViewModel, selected: Int = 0) {
        self.viewModel = viewModel
        self.selected = selected
    }

    var body: some View {
        List {
            ForEach(viewModel.stories ?? loadingPlaceholders) { story in
                if !story.isJobPost {
                    NavigationLink(destination:
                    CommentsView(viewModel: CommentsViewModel(story: story))) {
                        StoryView(story: story)
                          .redacted(reason: story.isPlaceholder ? .placeholder : [])
                    }
                } else {
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        StoryView(story: story)
                    }.sheet(isPresented: self.$isPresented) {
                        SafariView(url: story.url!)
                    }
                }
            }.animation(nil)
            Button(action: viewModel.loadMore) {
                GeometryReader { reader in
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Load more")
                            .font(.callout)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                }
                .padding(.vertical, 25)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .animation(nil)
        .listStyle(PlainListStyle())
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

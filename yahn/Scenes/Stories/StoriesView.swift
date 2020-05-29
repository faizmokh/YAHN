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

    @State var selected: Int = 0

    init(viewModel: StoriesViewModel = StoriesViewModel()) {
        self.viewModel = viewModel
        UITableView.appearance().separatorColor = .clear
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selected, label: EmptyView()) {
                    ForEach(0..<viewModel.topics.count) {
                        Text(self.viewModel.topics[$0].uppercased())
                        .tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()

                List {
                    ForEach(viewModel.stories) { story in
                        NavigationLink(destination:
                        CommentsView(viewModel: CommentsViewModel(story: story))) {
                            StoryView(story: story)
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
                    .padding()
                    .buttonStyle(SecondaryButtonStyle())
                }
                .onAppear(perform: {
                    self.viewModel.fetchStories()
                })
                    .navigationBarTitle("Front page")
            }
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}

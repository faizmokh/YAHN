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
    @State var isShowingDetail: Bool = false

    init(viewModel: StoriesViewModel = StoriesViewModel()) {
        self.viewModel = viewModel
        UITableView.appearance().separatorColor = .clear
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.stories) { story in
                    Button(action: {
                        self.isShowingDetail.toggle()
                    }, label: {
                        StoryView(story: story)
                    })
                        .sheet(isPresented: self.$isShowingDetail, content: {
                        SafariView(url: story.url!)
                    })
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
                }
                .padding()
                .buttonStyle(SecondaryButtonStyle())
            }
            .onAppear(perform: {
                self.viewModel.fetchStories()
            })
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}

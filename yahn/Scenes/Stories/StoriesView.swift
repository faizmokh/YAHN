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

    init(viewModel: StoriesViewModel = StoriesViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.stories) { story in
                StoryView(story: story)
            }
            Button(action: viewModel.loadMore) {
                GeometryReader { reader in
                    HStack(alignment: .center) {
                        Text("Load more")
                            .font(.callout)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    .frame(width: reader.size.width, height: 50, alignment: .center)
                    .background(Color.secondary)
                    .cornerRadius(8)
                }

            }
        }
        .onAppear(perform: viewModel.fetchStories)
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}

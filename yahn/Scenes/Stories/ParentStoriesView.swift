//
//  ParentStoriesView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 29/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct ParentStoriesView: View {

    let viewModel: ParentStoriesViewModel

    @State var selected: Int = 0

    init(viewModel: ParentStoriesViewModel = ParentStoriesViewModel()) {
        self.viewModel = viewModel
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
                if selected == 0 {
                    StoriesView(viewModel: StoriesViewModel(worker: HNWorker(type: .news)))
                } else if selected == 1 {
                    StoriesView(viewModel: StoriesViewModel(worker: HNWorker(type: .asks)))
                } else {
                    StoriesView(viewModel: StoriesViewModel(worker: HNWorker(type: .jobs)))
                }
            }
            .navigationBarTitle("Front page")
        }
    }
}

struct ParentStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ParentStoriesView()
    }
}

//
//  CommentsView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 24/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct CommentsView: View {

    @ObservedObject var viewModel: CommentsViewModel

    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.comments) { comment in
                CommentView(comment: comment)
            }
        }
        .onAppear(perform: viewModel.fetchComments)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static let story = Story(id: "123", title: "Ask HN: Is SwiftUI any good?", url: nil, domain: "swift.apple.com", points: 42, username: "faizmokhtar", relativeTime: "2 hours ago", commentCount: 69)

    static var previews: some View {
        CommentsView(viewModel: CommentsViewModel(story: story))
    }
}

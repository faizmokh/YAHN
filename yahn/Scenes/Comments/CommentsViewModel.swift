//
//  CommentsViewModel.swift
//  yahn
//
//  Created by Faiz Mokhtar on 24/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation

class CommentsViewModel: ObservableObject {

    let story: Story
    let worker: HNWorker

    @Published var comments: [Comment] = [Comment]()

    init(story: Story, worker: HNWorker = HNWorker()) {
        self.story = story
        self.worker = worker
    }

    func fetchComments() {
        worker.fetchComments(story: story) { result in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                break
            }
        }
    }
}

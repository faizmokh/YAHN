//
//  StoriesViewModel.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import SwiftUI

class StoriesViewModel: ObservableObject {

    let worker: HNWorker

    @Published var stories: [Story] = [Story]()
    private var nextLink: String?

    init(worker: HNWorker = HNWorker()) {
        self.worker = worker
    }

    func fetchStories() {
        worker.fetchStories { result in
            switch result {
            case .success(let stories, let nextLink):
                self.stories = stories
                self.nextLink = nextLink
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadMore() {
        guard let nextLink = self.nextLink else { return }
        worker.fetchMoreStories(link: nextLink) { result in
            switch result {
            case .success(let stories, let linkForMore):
                self.stories.append(contentsOf: stories)
                self.nextLink = linkForMore
            case .failure(let error):
                print(error)
            }
        }
    }
}

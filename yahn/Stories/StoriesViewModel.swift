//
//  StoriesViewModel.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import HNScraper

class StoriesViewModel: ObservableObject {

    let worker: HNWorker

    @Published var stories: [Story] = [Story]()

    init(worker: HNWorker = HNWorker()) {
        self.worker = worker
    }

    func fetchStories() {
        worker.fetchStories { result in
            switch result {
            case .success(let stories):
                print(stories)
                self.stories = stories
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  HNWorker.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import HNScraper

struct Story: Identifiable {
    let id: String
    let title: String
}

class HNWorker {
    func fetchStories(completion: @escaping (Result<[Story], Error>) -> Void) {
        var stories: [Story] = [Story]()
        HNScraper.shared.getPostsList(page: .front) { (posts, linkForMore, error) in
            if error != nil {
                return
            }

            for post in posts {
                let story = Story(id: post.id, title: post.title)
                stories.append(story)
                completion(.success(stories))
            }
        }
    }
}

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
    let url: URL?
    let domain: String
    let points: Int
    let username: String
    let commentCount: Int
}

class HNWorker {

    func fetchStories(completion: @escaping (Result<([Story], String?), Error>) -> Void) {
        var stories: [Story] = [Story]()
        HNScraper.shared.getPostsList(page: .best) { (posts, linkForMore, error) in
            if error != nil {
                return
            }

            for post in posts {
                let story = Story(
                    id: post.id,
                    title: post.title,
                    url: post.url,
                    domain: post.urlDomain,
                    points: post.points,
                    username: post.username,
                    commentCount: post.commentCount)
                stories.append(story)
                completion(.success((stories, linkForMore)))
            }
        }
    }

    func fetchMoreStories(linkForMore: String, completion: @escaping (Result<([Story], String?), Error>) -> Void) {
        var stories: [Story] = [Story]()
        HNScraper.shared.getMoreItems(linkForMore: linkForMore) { (posts, linkforMore, error) in
            if error != nil {
                return
            }

            for post in posts {
                let story = Story(
                    id: post.id,
                    title: post.title,
                    url: post.url,
                    domain: post.urlDomain,
                    points: post.points,
                    username: post.username,
                    commentCount: post.commentCount)
                stories.append(story)
                completion(.success((stories, linkForMore)))
            }
        }
    }
}

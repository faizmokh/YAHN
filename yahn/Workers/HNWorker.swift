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
    let relativeTime: String
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
                print(post.time)
                let story = Story(
                    id: post.id,
                    title: post.title,
                    url: post.url,
                    domain: post.urlDomain,
                    points: post.points,
                    username: post.username,
                    relativeTime: post.time,
                    commentCount: post.commentCount)
                stories.append(story)
                completion(.success((stories, linkForMore)))
            }
        }
    }

    func fetchMoreStories(link: String, completion: @escaping (Result<([Story], String?), Error>) -> Void) {
        var stories: [Story] = [Story]()
        HNScraper.shared.getMoreItems(linkForMore: link) { (posts, receivedLink, error) in
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
                    relativeTime: post.time,
                    commentCount: post.commentCount)
                stories.append(story)
            }

            completion(.success((stories, receivedLink)))
        }
    }
}

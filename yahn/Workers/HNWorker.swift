//
//  HNWorker.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import HNScraper

class HNWorker {

    let type: PageType

    init(type: PageType = .news) {
        self.type = type
    }

    func fetchStories(completion: @escaping (Result<([Story], String?), Error>) -> Void) {
        var stories: [Story] = [Story]()
        HNScraper.shared.getPostsList(page: type.scraperType) { (posts, linkForMore, error) in
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

    func fetchComments(story: Story, completion: @escaping (Result<[Comment], Error>) -> Void) {
        HNScraper.shared.getComments(ByPostId: story.id, buildHierarchy: false) { (post, receivedComments, error) in
            var comments: [Comment] = [Comment]()
            if error != nil {
                return
            }

            for received in receivedComments {
                let comment = Comment(
                    id: received.id,
                    text: received.text,
                    level: received.level,
                    username: received.username,
                    relativeTime: received.created
                )
                comments.append(comment)
            }

            completion(.success(comments))
        }
    }
}

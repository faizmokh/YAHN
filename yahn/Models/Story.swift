//
//  Story.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation

enum StoryType: String {
    case news
    case asks = "ask hn"
    case jobs
    case show = "show hn"
}

struct Story: Identifiable {
    let id: String
    let title: String
    let url: URL?
    let domain: String
    let points: Int
    let username: String
    let relativeTime: String
    let commentCount: Int
    let type: StoryType
}

extension Story {
  var isJobPost: Bool {
    return type == .jobs && url != nil
  }

  var isPlaceholder: Bool {
    return id == "placeholder"
  }
}

let staticStory = Story(
  id: "placeholder", title: "Ask HN: How deep is your love?",
  url: URL(string: "faizmokhtar.com"),
  domain: "faizmokhtar.com",
  points: 100,
  username: "faizmokh",
  relativeTime: "test date",
  commentCount: 100,
  type: .asks)

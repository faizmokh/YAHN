//
//  StoryView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct StoryView: View {
    let story: Story

    init(story: Story) {
        self.story = story
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(story.title)
                .font(.headline)
                .fontWeight(.bold)
            Text(story.domain)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.gray)
            Text("\(story.points) points by \(story.username) \(story.relativeTime) | \(story.commentCount) comments")
                .font(.caption)
                .fontWeight(.regular)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
    }
}

struct StoryView_Previews: PreviewProvider {
    static let story = Story(id: "123", title: "Ask HN: Is SwiftUI any good?", url: nil, domain: "swift.apple.com", points: 42, username: "faizmokhtar", relativeTime: "2 hours ago", commentCount: 69)
    static var previews: some View {
        StoryView(story: story)
            .previewLayout(.sizeThatFits)
    }
}

//
//  HeaderView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 24/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct HeaderView: View {

    @State var isShowingWebsite: Bool = false

    let story: Story

    private var a11yLabel: String {
        return "\(story.title), website:\(story.domain)"
    }

    private var a11yValue: String {
        return "Posted by \(story.username) \(story.relativeTime), with \(story.commentCount) comments and \(story.points) points."
    }

    init(story: Story) {
        self.story = story
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text(story.title)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(story.domain)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                Text("\(story.points) points by \(story.username) \(story.relativeTime)")
                    .font(.caption)
                    .fontWeight(.regular)
            }
            .accessibilityElement(children: .combine)
            .accessibility(label: Text(a11yLabel))
            .accessibility(value: Text(a11yValue))
            .padding(.top, 10)
            Button(action: {
                self.isShowingWebsite.toggle()
            }, label: {
                HStack(alignment: .center) {
                    Image(systemName: "globe")
                        .imageScale(.small)
                    Text("Open Website")
                        .font(.callout)
                        .fontWeight(.bold)
                }
                .padding()
            })
            .buttonStyle(SecondaryButtonStyle())
            .sheet(isPresented: self.$isShowingWebsite, content: {
                SafariView(url: self.story.url!)
            })
                .padding(.vertical, 10)
            Divider()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static let story = Story(id: "123", title: "Ask HN: Is SwiftUI any good?", url: nil, domain: "swift.apple.com", points: 42, username: "faizmokhtar", relativeTime: "2 hours ago", commentCount: 69, type: .news)

    static var previews: some View {
        HeaderView(story: story)
            .previewLayout(.sizeThatFits)
    }
}

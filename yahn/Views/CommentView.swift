//
//  CommentView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 24/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI
import SwiftSoup

struct CommentView: View {
    let comment: Comment

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<comment.level, id: \.self) { index in
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .frame(width: 1)
                        .padding(.leading, 10)
                }
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        Text(comment.username)
                            .font(.callout)
                            .fontWeight(.semibold)
                        Text(comment.relativeTime)
                            .font(.callout)
                            .fontWeight(.regular)
                    }
                    Text(parseHTML(text: comment.text))
                        .multilineTextAlignment(.leading)
                        .font(.body)
                }
                .padding(.all, 10)
            }
        }
    }

    private func parseHTML(text: String) -> String {
        do {
            let doc = try SwiftSoup.parse(text)
            return try doc.text()
        } catch {
            return text
        }
    }
}

struct CommentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CommentView(comment: Comment(id: "123", text: "hello world", level: 0, username: "faizmokhtar", relativeTime: "3h ago"))
                .previewLayout(.fixed(width: 200, height: 100))
            CommentView(comment:  Comment(id: "123", text: "hello world", level: 1, username: "faizmokhtar", relativeTime: "3h ago"))
                .previewLayout(.fixed(width: 200, height: 100))
            CommentView(comment:  Comment(id: "123", text: "hello world", level: 2, username: "faizmokhtar", relativeTime: "3h ago"))
                .previewLayout(.fixed(width: 200, height: 100))
            CommentView(comment:  Comment(id: "123", text: "hello world", level: 3, username: "faizmokhtar", relativeTime: "3h ago"))
                .previewLayout(.fixed(width: 200, height: 100))
        }
    }
}

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
        VStack {
            HStack {
                if comment.level > 0 {
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundColor(Color(hue: 1.0 / Double(comment.level), saturation: 1.0, brightness: 1.0))
                        .frame(width: 3)
                }
                Text(parseHTML(text: comment.text))
                    .font(.body)
            }
            .padding(.leading, CGFloat(comment.level * 10))
            Divider()
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
    static let comment = Comment(id: "123", text: "hello world", level: 0)

    static var previews: some View {
        CommentView(comment: comment)
            .previewLayout(.sizeThatFits)
    }
}

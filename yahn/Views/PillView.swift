//
//  PillView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 29/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct PillView: View {

    let type: StoryType

    var body: some View {
        Text(type.rawValue.uppercased())
            .font(.caption)
            .fontWeight(.bold)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .foregroundColor(.white)
            .if(type == .jobs) {
                $0.background(Color.blue)
            }
            .if(type == .asks) {
                $0.background(Color.orange)
            }
            .cornerRadius(20)
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PillView(type: .jobs)
                .previewLayout(.fixed(width: 100, height:100))
            PillView(type: .asks)
                .previewLayout(.fixed(width: 100, height:100))
        }
    }
}

//
//  ParentStoriesViewModel.swift
//  yahn
//
//  Created by Faiz Mokhtar on 29/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation

class ParentStoriesViewModel {
    var topics: [String] {
        PageType.allCases.map { $0.label }
    }

    func title(selected: Int) -> String {
        let title: String
        if selected == 0 {
            title = "Front Page"
        } else if selected == 1 {
            title = "Ask HN"
        } else {
            title = "Show HN"
        }

        return title
    }
}

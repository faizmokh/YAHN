//
//  PageType.swift
//  yahn
//
//  Created by Faiz Mokhtar on 29/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import HNScraper

enum PageType: Int, CaseIterable {
    case news
    case asks
    case jobs
}

extension PageType {
    var label: String {
        switch self {
        case .news:
            return "front"
        case .asks:
            return "ask"
        case .jobs:
            return "jobs"
        }
    }

    var scraperType: HNScraper.PostListPageName {
        switch self {
        case .news:
            return HNScraper.PostListPageName.news
        case .asks:
            return HNScraper.PostListPageName.asks
        case .jobs:
            return HNScraper.PostListPageName.jobs
        }
    }
}

//
//  Story.swift
//  yahn
//
//  Created by Faiz Mokhtar on 21/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation

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

import Foundation

// MARK: - Story
struct Story: Codable, Identifiable {
    let id: Int
    let by: String
    let descendants: Int
    let kids: [Int]
    let score, time: Int
    let title, type: String
    let url: String
}

extension Story: Comparable {
    static func < (lhs: Story, rhs: Story) -> Bool {
        return lhs.time > rhs.time
    }
}

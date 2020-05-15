import Foundation

// MARK: - Comment
struct Comment: Codable, Identifiable {
    let id: Int
    let by: String
    let kids: [Int]
    let parent: Int
    let text: String
    let time: TimeInterval
    let type: String
}

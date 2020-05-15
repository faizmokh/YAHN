import Foundation

// MARK: - Comment
struct Comment: Codable {
    let by: String
    let id: Int
    let kids: [Int]
    let parent: Int
    let text: String
    let time: Int
    let type: String
}

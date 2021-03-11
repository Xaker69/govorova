import Foundation

class BlockStreamModel: Decodable {
    let id: String
    let preview: String
    let name: String
    let status: String
    let start: String
    let end: String?
    let user: BlockStreamUser
    let reasonId: String?
    let moderator: BlockStreamModerator
    let reports: [Int: Int]?
    let previews: [BlockStreamUserPreview]?
    var isShort: Bool?
}

class BlockStreamUser: Decodable {
    let id: String
    let age: Int
    let name: String
    let avatar: String
}

class BlockStreamUserPreview: Decodable {
    let preview: String
    let previewVideo: String
}

class BlockStreamModerator: Decodable {
    let id: String
    let name: String
}

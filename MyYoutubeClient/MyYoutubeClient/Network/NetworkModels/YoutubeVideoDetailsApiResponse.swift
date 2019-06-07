import Foundation

struct YoutubeVideoDetailsApiResponse: Codable {
    let items: [DetailInfoItem?]
}

struct DetailInfoItem: Codable {
    let snippet: DetailInfoSnippet?
}

struct DetailInfoSnippet: Codable {
    let defaultAudioLanguage: String?
    let tags: [String]?
}

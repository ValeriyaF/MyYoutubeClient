import Foundation

struct YoutubeSearchApiResponse: Codable {
    let nextPageToken: String?
    let items: [Item]?
}

struct Item: Codable {
    let id: Id?
}

struct Id: Codable {
    let videoId: String?
    let snippet: Snippet?
}

struct Snippet: Codable {
    let title: String?
    let description: String?
    let thumbnails: Thumbnails?
}

struct Thumbnails: Codable {
    let medium: Medium?
}

struct Medium: Codable {
    let url: String?
}

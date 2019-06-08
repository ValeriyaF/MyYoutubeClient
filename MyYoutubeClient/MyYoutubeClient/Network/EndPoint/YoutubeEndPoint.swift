import Foundation

enum YoutubeApi {
    case search(word: String, nextPage: String)
    case videoDetail(videoId: String)
    case image(url: URL)
}

extension YoutubeApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        case .videoDetail:
            return "videos"
        case .image:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .search(let word, let nextPage):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["part": "snippet",
                                                      "maxResults": "25",
                                                      "q": word,
                                                      "type": "video",
                                                      "pageToken": nextPage,
                                                      "key": NetworkManager.api_key])
        case .videoDetail(let videoId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["part": "id,snippet",
                                                      "id": videoId,
                                                      "key": NetworkManager.api_key])
        case .image(let url):
            return .request(url: url)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}

import Foundation

enum YoutubeApi {
    case search(word: String)
    case videoDetail(videoId: String)
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
            return "videos?part=id,snippet"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .search(let word):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["part":"snippet",
                                                      "maxResults":"25",
                                                      "q":word,
                                                      "type":"video",
                                                      "key": NetworkManager.api_key])
        default:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["token": "AppConfig.testToken"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}

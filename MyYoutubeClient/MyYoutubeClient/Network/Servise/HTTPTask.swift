import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request(url: URL)
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
}

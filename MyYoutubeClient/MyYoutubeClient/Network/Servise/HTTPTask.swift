import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
}

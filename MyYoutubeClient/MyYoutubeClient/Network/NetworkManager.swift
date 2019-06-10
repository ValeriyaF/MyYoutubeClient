import Foundation

enum NetworkErrors: String {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result {
    case success
    case failure(String)
}

struct NetworkManager {
    static let api_key = ""
    let networkRouter = NetworkRouter<YoutubeApi>()
    
    func loadSearchResults(withQueryTerm word: String, nextPage: String, completion: @escaping (_ data: YoutubeSearchApiResponse?, _ error: String?) -> ()) {
        networkRouter.request(.search(word: word, nextPage: nextPage)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            completion(nil, NetworkErrors.noData.rawValue)
                        }
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(YoutubeSearchApiResponse.self, from: responseData)
                        DispatchQueue.main.async {
                            completion(apiResponse, nil)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(nil, NetworkErrors.unableToDecode.rawValue)
                        }
                    }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }
    
    func loadVideoInfo(forVideo id: String, completion: @escaping (_ data: YoutubeVideoDetailsApiResponse?, _ error: String?) -> ()) {
        networkRouter.request(.videoDetail(videoId: id)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            completion(nil, NetworkErrors.noData.rawValue)
                        }
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(YoutubeVideoDetailsApiResponse.self, from: responseData)
                        DispatchQueue.main.async {
                            completion(apiResponse, nil)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(nil, NetworkErrors.unableToDecode.rawValue)
                        }
                    }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
        
    }
    
    func loadImage(fromURL url: URL, completion: @escaping (_ data: Data?, _ error: String?) -> ()) {
        networkRouter.request(.image(url: url)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            completion(nil, NetworkErrors.noData.rawValue)
                        }
                        return
                    }
                        DispatchQueue.main.async {
                            completion(responseData, nil)
                        }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
        
    }
    
}

private extension NetworkManager {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkErrors.authenticationError.rawValue)
        case 501...599: return .failure(NetworkErrors.badRequest.rawValue)
        case 600: return .failure(NetworkErrors.outdated.rawValue)
        default: return .failure(NetworkErrors.failed.rawValue)
        }
    }
}


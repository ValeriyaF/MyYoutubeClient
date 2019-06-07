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
    static let api_key = "AIzaSyBMX0bQeTqFZKYbqNZN66-Kigx1Dsb6Tps"
    let networkRouter = NetworkRouter<YoutubeApi>()
    
    func getSearchResults(withQueryTerm word: String, completion: @escaping (_ data: YoutubeSearchApiResponse?, _ error: String?) -> ()) {
        networkRouter.request(.search(word: word)) { data, response, error in
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
                        completion(nil, NetworkErrors.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
            
        }
    }
    
//    func getMembers(forEvent eventid: Int, completion: @escaping (_ data: EventMembersApiResponse?, _ error: String?) -> ()) {
//        networkRouter.request(.members(eventId: eventid)) { data, response, error in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue)
//                        return
//                    }
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        let apiResponse = try JSONDecoder().decode(EventMembersApiResponse.self, from: responseData)
//                        completion(apiResponse, nil)
//                    } catch {
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError)
//                }
//            }
//        }
//    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkErrors.authenticationError.rawValue)
        case 501...599: return .failure(NetworkErrors.badRequest.rawValue)
        case 600: return .failure(NetworkErrors.outdated.rawValue)
        default: return .failure(NetworkErrors.failed.rawValue)
        }
    }
}


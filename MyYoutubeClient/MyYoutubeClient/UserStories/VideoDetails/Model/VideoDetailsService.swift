import Foundation

final class VideoDetailsService {
    private let networkManager = NetworkManager()
    
    func getVideoInfo(withQueryTerm word: String, completion: @escaping (_ data: YoutubeVideoDetailsApiResponse?, _ error: String?) -> ()) {
        networkManager.loadVideoInfo(forVideo: word) { data, error in
            completion(data, error)
        }
    }
    
}

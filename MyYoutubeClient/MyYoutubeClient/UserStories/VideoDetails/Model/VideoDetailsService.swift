import Foundation

final class VideoDetailsService {
    private let networkManager = NetworkManager()
    

    private let api_key = "AIzaSyBMX0bQeTqFZKYbqNZN66-Kigx1Dsb6Tps" // network layer
    
    func getVideoInfo(withQueryTerm word: String, completion: @escaping (_ data: YoutubeVideoDetailsApiResponse?, _ error: String?) -> ()) {
        networkManager.loadVideoInfo(forVideo: word) { data, error in
            completion(data, error)
        }
    }

}

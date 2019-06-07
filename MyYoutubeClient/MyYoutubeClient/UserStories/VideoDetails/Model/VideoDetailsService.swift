import Foundation

final class VideoDetailsService {
    private let api_key = "AIzaSyBMX0bQeTqFZKYbqNZN66-Kigx1Dsb6Tps" // network layer
    func getVideoInfo(forVideo id: String, completion: @escaping (_ data: YoutubeVideoDetailsApiResponse, _ error: Error?) -> ()) {
        var downloadedData: YoutubeVideoDetailsApiResponse?
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=id,snippet&id=\(id)&key=\(api_key)") else {
            print("video detail url error")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                do {
                    downloadedData = try JSONDecoder().decode(YoutubeVideoDetailsApiResponse.self, from: data)
                    print(downloadedData)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                completion(downloadedData!, error)
            }
            }.resume()
    }
}

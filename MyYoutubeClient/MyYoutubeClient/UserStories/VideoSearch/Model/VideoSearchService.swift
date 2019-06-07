import UIKit

final class VideoSearchService {
    private let api_key = "AIzaSyBMX0bQeTqFZKYbqNZN66-Kigx1Dsb6Tps" // network layer
    private let cache = NSCache<NSString, UIImage>()
    private var imageUrls: [String] = []
    
    func getSearchResults(withQueryTerm word: String, completion: @escaping (_ data: YoutubeSearchApiResponse, _ error: Error?) -> ()) {
        var downloadedData: YoutubeSearchApiResponse?
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=\(word)&type=video&key=\(api_key)") else {
            print("url problem")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                do {
                    downloadedData = try JSONDecoder().decode(YoutubeSearchApiResponse.self, from: data)
                    self?.imageUrls = downloadedData?.items?.compactMap { $0.snippet?.thumbnails?.medium?.url } ?? []
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                completion(downloadedData!, error)
            }
        }.resume()
    }
    
    func getImege(forIndex index: Int, completion: @escaping (_ image: UIImage?) -> ()) {
        guard let imageUrl = URL(string: imageUrls[index]) else {
            print("url problem")
            return
        }
        
        if let image = cache.object(forKey: imageUrl.absoluteString as NSString) {
            completion(image)
        } else {
            loadImage(withUrl: imageUrl, completion: completion)
        }
    }
    
    func loadImage(withUrl url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            var loadedImage: UIImage?
            
            if let data = data {
                loadedImage = UIImage(data: data)
            }
            
            if let loadedImage = loadedImage {
                self?.cache.setObject(loadedImage, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(loadedImage)
            }
            
        }.resume()
    }
    
}

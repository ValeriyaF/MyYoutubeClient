import UIKit

final class VideoSearchService {
    private let networkManager = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    private var imageUrls: [String] = []
    
    func getSearchResults(withQueryTerm word: String, nextPage: String, completion: @escaping (_ data: YoutubeSearchApiResponse?, _ error: String?) -> ()) {
        networkManager.loadSearchResults(withQueryTerm: word, nextPage: nextPage) { [weak self] data, error in
            if let data = data {
                self?.imageUrls = data.items.compactMap { $0?.snippet?.thumbnails?.medium?.url }
            }
            completion(data, error)
        }
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

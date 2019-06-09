import UIKit

final class VideoSearchService {
    static var imageURLs: [String] = []
    
    private let networkManager: NetworkManager?
    private let cache = NSCache<NSString, UIImage>()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getSearchResults(withQueryTerm word: String, nextPage: String, completion: @escaping (_ data: YoutubeSearchApiResponse?, _ error: String?) -> ()) {
        networkManager?.loadSearchResults(withQueryTerm: word, nextPage: nextPage) { [weak self] data, error in
            if let data = data {
                if nextPage == "" {
                    VideoSearchService.imageURLs.removeAll()
                    self?.cache.removeAllObjects()
                    VideoSearchService.imageURLs = data.items.compactMap { $0?.snippet?.thumbnails?.medium?.url }
                } else {
                    VideoSearchService.imageURLs.append(contentsOf: data.items.compactMap { $0?.snippet?.thumbnails?.medium?.url })
                }
            }
            completion(data, error)
        }
    }
    
    func getImege(forIndex index: Int, completion: @escaping (_ image: UIImage?) -> ()) {
        guard let imageUrl = URL(string: VideoSearchService.imageURLs[index]) else {
            return
        }
        
        if let image = cache.object(forKey: imageUrl.absoluteString as NSString) {
            completion(image)
            
        } else {
            networkManager?.loadImage(fromURL: imageUrl) { data, error in
                var loadedImage: UIImage?
                
                if let data = data {
                    loadedImage = UIImage(data: data)
                }
                
                if let loadedImage = loadedImage {
                    self.cache.setObject(loadedImage, forKey: imageUrl.absoluteString as NSString)
                }
                
                completion(loadedImage)
            }
        }
    }

}

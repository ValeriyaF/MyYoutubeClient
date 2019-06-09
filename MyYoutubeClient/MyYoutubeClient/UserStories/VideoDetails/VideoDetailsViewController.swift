import UIKit

final class VideoDetailsViewController: UIViewController {
    
    var sharedData: VideoDetailsDataToShare = VideoDetailsDataToShare()
    
    var detailView: IVideoDetailsView!
    var model: VideoDetailsService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        detailView.configureVideoInfo(with: sharedData)
        
        model.getVideoInfo(withQueryTerm: sharedData.videoId) { [weak self] data, error in
            
            guard let data = data else {
                let alert = UIAlertController(title: "Sorry", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.self?.present(alert, animated: true, completion: nil)
                return
            }
            var tags: [String] = []
            data.items.forEach { tags += $0?.snippet?.tags ?? [] }
            self?.detailView.configureTagsLabel(with: tags)
        }
    }
    
}

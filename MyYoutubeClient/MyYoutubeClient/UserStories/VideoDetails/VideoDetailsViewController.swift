import UIKit

struct VideoDetailsDataToShare {
    let title: String
    let videoId: String
    let channelTitle: String
    
    init(model: Item) {
        self.title = model.snippet?.title ?? ""
        self.videoId = model.id?.videoId ?? ""
        self.channelTitle = model.snippet?.channelTitle ?? ""
    }
    
    init() {
        self.title = ""
        self.videoId = ""
        self.channelTitle = ""
    }
}
final class VideoDetailsViewController: UIViewController {
    
    var sharedData: VideoDetailsDataToShare = VideoDetailsDataToShare()
    
    var detailView: VideoDetailsView!
    var model: VideoDetailsService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        detailView.configureVideoInfo(with: sharedData)
        model.getVideoInfo(withQueryTerm: sharedData.videoId) { [weak self] data, error in
            
            guard let data = data else {
                // show alert with text or smth
                print(error)
                return
            }
            var tags: [String] = []
            print(data.items.forEach { tags += ($0?.snippet?.tags ?? [""]) })
            self?.detailView.configureTagsLabel(with: tags)
        }
    }
    
}

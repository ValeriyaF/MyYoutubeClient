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
        model.getVideoInfo(forVideo: sharedData.videoId) { [weak self] (data, error) in
            var tags: [String] = []
            data.items.compactMap { $0?.snippet?.tags }.forEach { tags += $0 }
            self?.detailView.configureTagsLabel(with: tags)

        }
    }
}

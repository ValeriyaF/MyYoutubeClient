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
    private let detailView = VideoDetailsView()
    private let model = VideoDetailsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        detailView.configureVideo(with: sharedData)
        model.getVideoInfo(forVideo: sharedData.videoId) { (data, error) in
            print(error ?? "")
        }
    }
}

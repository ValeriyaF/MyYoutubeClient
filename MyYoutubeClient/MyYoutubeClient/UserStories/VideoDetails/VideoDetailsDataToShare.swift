import Foundation


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

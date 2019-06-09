import Foundation

struct YoutubeSearchResults {
    let items: [Item]
    
    init(response: YoutubeSearchApiResponse) {
        self.items = response.items.compactMap { $0 }
    }
}

struct VideoSearchCellModel {
    let title: String
    let description: String
    
    init(snippet: Snippet?) {
        self.title = snippet?.title ?? ""
        self.description = snippet?.description ?? ""
    }
}

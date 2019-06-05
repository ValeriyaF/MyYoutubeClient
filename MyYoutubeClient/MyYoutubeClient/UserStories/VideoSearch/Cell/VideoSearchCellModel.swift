import Foundation

struct VideoSearchCellModel {
    let title: String
    let description: String
    
    init(snippet: Snippet?) {
        self.title = snippet?.title ?? ""
        self.description = snippet?.description ?? ""
    }
    
//    init(title: String? = nil, description: String? = nil) {
//        self.title = ""
//        self.description = ""
//    }
    //    init(snippet: Snippet? = nil) {
    //        self.title = ""
    //        self.description = ""
    //    }
}

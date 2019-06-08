import UIKit

struct YoutubeSearchResults {
    let items: [Item]
    
    init(response: YoutubeSearchApiResponse) {
        self.items = response.items.compactMap { $0 }
    }
}

final class VideoSearchViewController: UIViewController {
    
    var clichOnCellHandler: ((_ item: VideoDetailsDataToShare) -> Void)?
    
    var model: VideoSearchService!
    var mainView:VideoSearchView!
    
    private var nextPageToken: String = ""
    private var queryText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
        mainView.cellClickHandler = { [weak self] item in
            self?.clichOnCellHandler?(item)
        }
        
        mainView.searchTextAppearHandler = { text in
            guard let text = text else {
                return
            }
            if text != "" {
                self.mainView.startLoadVideoList()
                self.nextPageToken = ""
                self.queryText = text
                self.model.getSearchResults(withQueryTerm: self.queryText, nextPage: self.nextPageToken, completion: { data, error in
                    guard let data = data else {
                        print(error) // show alert or smth
                        return
                    }
                    self.nextPageToken = data.nextPageToken ?? ""
                    self.mainView.updateSearchResults(withNewResults: YoutubeSearchResults(response: data))
                    self.mainView.endLoadVideoLest()
                })
            }
        }
        
        mainView.fetchNewPageHandler = {
            if self.nextPageToken == "" {
                return
            }
            self.model.getSearchResults(withQueryTerm: self.queryText, nextPage: self.nextPageToken,
                                        completion: { data, error in
                                            guard let data = data else {
                                                print(error)
                                                return
                                            }
                                            self.nextPageToken = data.nextPageToken ?? ""
                                            self.mainView.fetchSearchResults(withNewResults: YoutubeSearchResults(response: data))
                                            
            })
        }
        
    }
    
}




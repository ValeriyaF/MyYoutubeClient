import UIKit

final class VideoSearchViewController: UIViewController {
    
    var clichOnCellHandler: ((_ item: VideoDetailsDataToShare) -> Void)?
    
    var model: VideoSearchService!
    var mainView: IVideoSearchView! {
        didSet {
            self.mainView.cellClickHandler = { [weak self] item in
                self?.clichOnCellHandler?(item)
            }
            
            self.mainView.searchTextAppearHandler = { text in
                self.searchVideos(withQueryTerm: text)
            }
            
            self.mainView.fetchNewPageHandler = {
                self.fetchNewSearchResults()
            }
            
        }
    }
    
    private var nextPageToken: String = ""
    private var queryText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
    }
    
}

private extension VideoSearchViewController {
    func searchVideos(withQueryTerm word: String?) {
        guard let word = word else {
            return
        }
        if word != "" {
            self.mainView.startLoadVideoList()
            self.nextPageToken = ""
            self.queryText = word
            self.model.getSearchResults(withQueryTerm: self.queryText, nextPage: self.nextPageToken) { data, error in
                guard let data = data else {
                    let alert = UIAlertController(title: "Sorry", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.self.present(alert, animated: true, completion: nil)
                    
                    self.mainView.endLoadVideoLest()
                    return
                }
                self.nextPageToken = data.nextPageToken ?? ""
                self.mainView.updateSearchResults(withNewResults: YoutubeSearchResults(response: data))
                self.mainView.endLoadVideoLest()
            }
        }
    }
    
    func fetchNewSearchResults() {
        if self.nextPageToken == "" {
            return
        }
        self.model.getSearchResults(withQueryTerm: self.queryText, nextPage: self.nextPageToken)
        { data, error in
            guard let data = data else {
                return
            }
            self.nextPageToken = data.nextPageToken ?? ""
            self.mainView.fetchSearchResults(withNewResults: YoutubeSearchResults(response: data))
            
        }
    }
}




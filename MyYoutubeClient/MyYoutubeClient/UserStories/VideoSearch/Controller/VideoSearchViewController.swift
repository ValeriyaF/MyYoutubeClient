import UIKit

final class VideoSearchViewController: UIViewController {
    
    internal var clichOnCellHandler: ((_ item: VideoDetailsDataToShare) -> Void)?
    
    var model: VideoSearchService!
    var mainView:VideoSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
        mainView.cellClickHandler = { [weak self] item in
            self?.clichOnCellHandler?(item)
        }
        
        mainView.searchTextAppearHandler = { [weak self] text in
            guard let text = text else {
                return
            }
            if text != "" {
                self?.mainView.startLoadVideoList()
                NetworkManager().getSearchResults(withQueryTerm: text, completion: { (data, error) in
                    guard let data = data else {
                        print(error)
                        return
                    }
                    self?.mainView.updateSearchResults(withNewResults: data)
                    self?.mainView.endLoadVideoLest()
                })
//                self?.model.getSearchResults(withQueryTerm: text) { data, error in
//                    self?.mainView.updateSearchResults(withNewResults: data)
//                    self?.mainView.endLoadVideoLest()
//                }
            }
        }
        
//        mainView.loadImageForCellHeandler = { index in
//            self.model.getImege(forIndex: index, completion: { image in
////                self.mainView.setupImage(forCellIndex: index, image: image)
//            })
//
//        }
        

        
    }

}


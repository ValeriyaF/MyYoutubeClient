import UIKit

final class VideoSearchViewController: UIViewController {
    
    var clichOnCellHandler: (() -> Void)?
    
    private let model = VideoSearchService()
    private let mainView = VideoSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
        mainView.cellClickHandler = { [weak self] in self?.clichOnCellHandler?() }
        
        mainView.searchTextAppearHandler = { [weak self] text in
            guard let text = text else {
                return
            }
            if text != "" {
                self?.mainView.startLoadVideoList()
                self?.model.getSearchResults(withQueryTerm: text) { data, error in
                    self?.mainView.updateSearchResults(withNewResults: data)
                    self?.mainView.endLoadVideoLest()
                }
            }
        }
        
        mainView.imageForCell = { index in
            self.model.getImege(forIndex: index, completion: { image in
                self.mainView.setupImage(forCellIndex: index, image: image)
            })
        }
        

        
    }

}


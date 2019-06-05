import UIKit

final class VideoSearchViewController: UIViewController {
    
    var clichOnCellHandler: (() -> Void)?
    
    private let model = VideoSearchModel()
    private let mainView = VideoSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
    }


}


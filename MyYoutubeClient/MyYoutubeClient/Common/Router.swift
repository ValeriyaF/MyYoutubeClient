import UIKit

final class Router {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showInitialViewController() {
        let firstVC = VideoSearchViewController()
        firstVC.clichOnCellHandler = { [weak self] in
            self?.moveToDetailsViewController()
        }
        self.navigationController.setViewControllers([firstVC], animated: false)
    }
    
    func moveToDetailsViewController() {
        print("move to")
    }
}



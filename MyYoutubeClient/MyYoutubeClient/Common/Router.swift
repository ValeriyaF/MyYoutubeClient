import UIKit

final class Router {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showInitialViewController() {
        let firstVC = VideoSearchViewController()
        firstVC.clichOnCellHandler = { [weak self] item in
            self?.moveToDetailsViewController(withDataToShare: item)
        }
        self.navigationController.setViewControllers([firstVC], animated: false)
    }
    
    func moveToDetailsViewController(withDataToShare data: VideoDetailsDataToShare) {
        var detailsViewController = VideoDetailsViewController()
        passDataToDetailsViewController(source: data, destination: &detailsViewController)
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    private func passDataToDetailsViewController(source: VideoDetailsDataToShare, destination: inout VideoDetailsViewController) {
        destination.sharedData = source
    }
}



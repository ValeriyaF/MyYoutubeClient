import UIKit

final class Router {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showInitialViewController() {
        let initialVC = VideoSearchViewController()
        initialVC.model = VideoSearchService()
        initialVC.mainView = VideoSearchView()
        initialVC.clichOnCellHandler = { [weak self] item in
            self?.moveToDetailsViewController(withDataToShare: item)
        }
        self.navigationController.setViewControllers([initialVC], animated: false)
    }
    
    func moveToDetailsViewController(withDataToShare data: VideoDetailsDataToShare) {
        var detailsViewController = VideoDetailsViewController()
        detailsViewController.detailView = VideoDetailsView()
        detailsViewController.model = VideoDetailsService()
        passDataToDetailsViewController(source: data, destination: &detailsViewController)
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    private func passDataToDetailsViewController(source: VideoDetailsDataToShare, destination: inout VideoDetailsViewController) {
        destination.sharedData = source
    }
}



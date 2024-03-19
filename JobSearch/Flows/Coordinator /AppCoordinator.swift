//
//  AppCoordinator.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit
import Combine

final class AppCoordinator {
    private let window: UIWindow
    private let tabBarController: TabBarController
    private let mainCoordinator: MainCoordinator
    private var authCoordinator: AuthCoordinator?
    private var cancellables = Set<AnyCancellable>()
    private let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        
        self.tabBarController = TabBarController()
        self.mainCoordinator = MainCoordinator(tabBarController: tabBarController)
    }
    
    func start() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        showAuthFlow()
    }
    
    private func showMainFlow() {
        mainCoordinator.start()
        navigationController.removeFromParent()
    }
    private func showAuthFlow() {
        let navigationController = UINavigationController()
        tabBarController.setViewControllers([navigationController], animated: true)
        
        authCoordinator = AuthCoordinator(presentingViewController: navigationController, tabBarController: tabBarController)
        authCoordinator?.$didFinishAuthenticating
            .sink  {[weak self] stus in
                if stus == true {
                    self?.showMainFlow() }
            }
            .store(in: &cancellables)
        authCoordinator?.start()
    }
}

final class MainCoordinator {
    private let favoriteStorage = FavoriteStorage()
    private let dataService = JobsFetcherService()
    private let tabBarController: TabBarController
    
    init(tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let searchViewModel = SearchViewModel(favoriteStorage: favoriteStorage, jobsDataService: dataService)
        let searchViewController = SearchViewController()
        searchViewController.setViewModel(searchViewModel)
        
        let favoriteViewModel = FavoriteViewModel(favoriteStorage: favoriteStorage, jobsDataService: dataService)
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.setViewModel(favoriteViewModel)
        
        let firstNavController = UINavigationController(rootViewController: searchViewController)
        let secondNavController = UINavigationController(rootViewController: favoriteViewController)
        
        tabBarController.addController(viewControler: firstNavController, tabBarType: .search)
        tabBarController.addController(viewControler: secondNavController, tabBarType: .favorite)
        tabBarController.addController(viewControler: UIViewController(), tabBarType: .response)
        tabBarController.addController(viewControler: UIViewController(), tabBarType: .message)
        tabBarController.addController(viewControler: UIViewController(), tabBarType: .profile)
        tabBarController.cofigure()
    }
}


class AuthCoordinator {
    @Published var didFinishAuthenticating: Bool = false
    
    private let presentingViewController: UIViewController
    private let tabBarController: TabBarController
    
    init(presentingViewController: UIViewController, tabBarController: TabBarController) {
        self.presentingViewController = presentingViewController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let authViewController = FirstLoginViewController()
        authViewController.setCoordinator(self)
        authViewController.modalPresentationStyle = .fullScreen
        presentingViewController.present(authViewController, animated: true)
    }
    
    private func showMainScreen() {
        presentingViewController.dismiss(animated: true) {
            self.didFinishAuthenticating = true
            UIApplication.shared.windows.first?.rootViewController = self.tabBarController
        }
    }
    
    func didFinishAuthentication() {
        showMainScreen()
    }
}

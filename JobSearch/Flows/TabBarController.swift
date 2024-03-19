//
//  TabBarController.swift
//  JobSearch
//
//  Created by user on 14.03.2024.
//

import UIKit

enum CustomTabBarItem: String, CaseIterable {
    case search
    case favorite
    case response
    case message
    case profile
    
    var displayTitle: String {
        switch self {
        case .search:
            return "Поиск"
        case .favorite:
            return "Избранное"
        case .response:
            return "Отклики"
        case .message:
            return "Сообщения"
        case .profile:
            return "Профиль"
        }
    }
}

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundImage = UIImage()
        tabBar.isTranslucent = false
        setupTabBarAppearance()
    }
    private var controllrList: [UIViewController] = []
    
    func addController(viewControler: UIViewController, tabBarType: CustomTabBarItem) {
        viewControler.tabBarItem.title = tabBarType.title
        viewControler.tabBarItem.image = tabBarType.icon
        controllrList.append(viewControler)
    }
    func cofigure() {
        setViewControllers(controllrList, animated: true)
    }
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.specialBlue]
        
        tabBarItemAppearance.normal.iconColor = .white
        tabBarItemAppearance.selected.iconColor = .specialBlue
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabBarAppearance
    }
}

extension CustomTabBarItem {
    var icon: UIImage? { return UIImage(named: String(self.rawValue)) }
    
    var title: String {
        return self.displayTitle
    }
}

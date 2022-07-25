//
//  Tabbar.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation
import UIKit

final class BaseTabbarViewController: UITabBarController {
    private static var sharedTabbarManager: BaseTabbarViewController = {
        let tabbarManager = BaseTabbarViewController()
        return tabbarManager
    }()

    class func shared() -> BaseTabbarViewController {
        return sharedTabbarManager
    }

    func createTabbar() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(systemName: "house.fill"), tag: 0)
        let homeNavi = UINavigationController(rootViewController: homeVC)

        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem = UITabBarItem(title: "Khám phá", image: UIImage(systemName: "safari.fill"), tag: 1)
        let exploreNavi = UINavigationController(rootViewController: exploreVC)

        let storyVC = StoryViewController()
        storyVC.tabBarItem = UITabBarItem(title: "Câu chuyện", image: UIImage(systemName: "eye.fill"), tag: 2)
        let storyNavi = UINavigationController(rootViewController: storyVC)

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Tài khoản", image: UIImage(systemName: "person.fill"), tag: 3)
        let profileNavi = UINavigationController(rootViewController: profileVC)

        self.viewControllers = [homeNavi, exploreNavi, storyNavi, profileNavi]
    }
}

//
//  TabBarController.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    static var sharedInstance: TabBarController? {
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        return window?.rootViewController as? TabBarController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTabBar(viewControllers: [UIViewController(), UIViewController()], tabs: [.scan, .profile])
    }
    
    func loadTabBar(viewControllers: [UIViewController], tabs: [TabBarItem]) {
        var tempViewControllers = [UIViewController]()
        for (index, viewController) in viewControllers.enumerated() {
            guard let tabItem = tabs.object(index: index) else {
                return
            }
            let tabBarItem = UITabBarItem(title: tabItem.title, image: tabItem.icon, tag: index)
            
            viewController.tabBarItem = tabBarItem
            tempViewControllers.append(viewController)
        }
        
        self.viewControllers = tempViewControllers
        consistToTheme()
    }
    
    func customizeTabBarItems() {
        //use this to reorder or add items to the tabbar
        //just make sure that in storyboard the order is respected
        let icons: [TabBarItem] = [.scan, .profile]
        
        for (index, icon) in icons.enumerated() {
            let tabBarIcon = self.tabBar.items?.object(index: index)
            tabBarIcon?.image = icon.icon
            tabBarIcon?.title = icon.title
            tabBarIcon?.selectedImage = icon.icon
            if let barButton = self.tabBar.subviews.filter({ $0.accessibilityLabel == icon.title }).first {
                barButton.accessibilityIdentifier = "UITabBar.\(icon.accessibilityIdentifier)"
            }
        }
        
        consistToTheme()
    }
    
    func switchTabBar(selected: TabBarItem) {
        self.selectedIndex = selected.rawValue
    }
    
    internal func consistToTheme() {
//        view.backgroundColor = .red
        tabBar.tintColor = .white
        tabBar.barTintColor = .red
        tabBar.unselectedItemTintColor = .gray
        tabBar.items?.forEach { item in
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        }
    }
}

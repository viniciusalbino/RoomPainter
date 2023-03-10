//
//  CustomNavigationBar.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        consistToTheme()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func consistToTheme() {
        let buttonAppearance = UIBarButtonItemAppearance()
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.designSystem(.textSecondaryColor)]
        buttonAppearance.normal.titleTextAttributes = attributes
        buttonAppearance.highlighted.titleTextAttributes = attributes
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .designSystem(.primaryColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.designSystem(.textSecondaryColor)]
        appearance.buttonAppearance = buttonAppearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

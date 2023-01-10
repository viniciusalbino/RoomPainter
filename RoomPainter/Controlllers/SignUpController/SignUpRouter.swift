//
//  SignUpInterface.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation
import UIKit

protocol SignUPWireframeBuilder: AnyObject {
    func createModule() -> UIViewController
}

final class SignUpWireframeBuilder: SignUPWireframeBuilder {
    
    func createModule() -> UIViewController {
        let router = SignUpRouter()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter(router: router, interactor: interactor)
        interactor.output = presenter
        let viewController = SignUpViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

final class SignUpRouter: SignUpRouterProtocol {
    // MARK: - Private properties -
    weak var viewController: UIViewController?
    
    // MARK: - Module setup -
    
}

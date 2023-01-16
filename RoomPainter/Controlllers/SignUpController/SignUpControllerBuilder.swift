//
//  SignUpControllerBuilder.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit

final class SignUpControllerBuilder: ViewControllerBuilder {
    func build() -> UIViewController {
        let router = SignUpRouter()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter(router: router, interactor: interactor)
        interactor.output = presenter
        let viewController = SignUpViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

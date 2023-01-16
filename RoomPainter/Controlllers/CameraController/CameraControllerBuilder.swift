//
//  CameraControllerBuilder.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 16/01/23.
//

import Foundation
import UIKit

class CameraControllerBuilder: ViewControllerBuilder {
    func build() -> UIViewController {
        let router = CameraRouter()
        let interactor = CameraInteractor()
        let presenter = CameraPresenter(router: router, interactor: interactor)
        interactor.output = presenter
        let viewController = CameraViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

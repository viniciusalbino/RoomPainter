//
//  CameraController.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 16/01/23.
//

import Foundation
import UIKit

class CameraViewController: UIViewController {
    // MARK: - Viper Properties
    private let presenter: CameraPresenterInputProtocol
    
    // MARK: - Variables
    
    // MARK: - Init
    
    init(presenter: CameraPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .designSystem(.secondaryColor)
    }
}

// MARK: - Presenter output protocol
extension CameraViewController: CameraPresenterOutputProtocol {
    
}

//
//  SignUpController.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation
import UIKit

final class SignUpViewController: UIViewController {
    // MARK: - Viper Properties
    private let presenter: SignUpPresenterInputProtocol
    
    // MARK: - Init
    
    init(presenter: SignUpPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - Presenter output protocol
extension SignUpViewController: SignUpPresenterOutputProtocol {
    
}

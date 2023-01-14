//
//  SignUpController.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation
import UIKit
import AuthenticationServices

final class SignUpViewController: UIViewController {
    // MARK: - Viper Properties
    private let presenter: SignUpPresenterInputProtocol
    
    // MARK: - Variables
    private var loginButton = ASAuthorizationAppleIDButton()
    
    // MARK: - Init
    
    init(presenter: SignUpPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.soma(.primaryColor)
        addViews()
    }
    
    // MARK: - Setup Views
    private func addViews() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(authorizeUser), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 46),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Private Methods
    @objc private func authorizeUser() {
        startLoading()
        presenter.requestAppleAuthorization()
    }
}

// MARK: - Presenter output protocol
extension SignUpViewController: SignUpPresenterOutputProtocol {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func finishedLogin(success: Bool) {
        if success {
            stopLoading()
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneClass : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sceneClass.showFirstController()
            }

        }
    }
}

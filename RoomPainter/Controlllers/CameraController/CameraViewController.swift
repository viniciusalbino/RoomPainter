//
//  CameraController.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 16/01/23.
//

import Foundation
import UIKit
import RoomPlan

class CameraViewController: UIViewController {
    // MARK: - Viper Properties
    private let presenter: CameraPresenterInputProtocol
    
    // MARK: - Variables
    private var roomCaptureView: RoomCaptureView!
    private var roomCaptureSessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
    private var finalResults: CapturedRoom?
    private var isScanning: Bool = false
    
    private var descriptionLabel: UILabel!
    private var startButton: PrimaryButton!
    private var doneButton: UIBarButtonItem!
    private var cancelButton: UIBarButtonItem!
    
    // MARK: - Init
    
    init(presenter: CameraPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .designSystem(.secondaryColor)
        setupComponents()
    }
    
    private func setupComponents() {
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.textColor = .designSystem(.textPrimaryColor)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: CGFloat.fontSize(.fontSizeLg))
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "To scan your room, point your device at all the walls, windows, doors and furniture in your space until your scan is complete. \nYou can see a preview of your scan at the bottom of the screen so you can make sure your scan is correct.".localized()
        view.addSubview(descriptionLabel)
        
        startButton = PrimaryButton(frame: .zero)
        startButton.setTitle("Iniciar".localized(), for: .normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(startButton)
        
        cancelButton = UIBarButtonItem(title: "Cancelar".localized(), style: .plain, target: self, action: #selector(cancel))
        doneButton = UIBarButtonItem(title: "Finalizar".localized(), style: .done, target: self, action: #selector(doneCapturing))
        navigationItem.rightBarButtonItem = doneButton
        doneButton.tintColor = .designSystem(.secondaryColor)
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .designSystem(.secondaryColor)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat.spacing(.spacingMd)),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat.spacing(.spacingMd)),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CGFloat.spacing(.spacingMd)),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: CGFloat.spacing(.spacingMd)),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Private methods
    
    private func startSession() {
        isScanning = true
        roomCaptureView?.captureSession.run(configuration: roomCaptureSessionConfig)
        
        setActiveNavBar()
    }
    
    private func stopSession() {
        isScanning = false
        roomCaptureView?.captureSession.stop()
        
        setCompleteNavBar()
    }
    
    private func setActiveNavBar() {
        UIView.animate(withDuration: 1.0, animations: {
            self.cancelButton?.tintColor = .designSystem(.textSecondaryColor)
            self.doneButton?.tintColor = .designSystem(.textSecondaryColor)
            
            self.descriptionLabel.alpha = 0.0
            self.startButton.alpha = 0.0
        }, completion: { complete in
            
        })
    }
    
    private func setCompleteNavBar() {
        UIView.animate(withDuration: 1.0) {
            self.cancelButton?.tintColor = UIColor.designSystem(.secondaryColor)
            self.doneButton?.tintColor = UIColor.designSystem(.secondaryColor)
        }
    }
    
    private func setActiveStartButtons() {
        UIView.animate(withDuration: 1.0, animations: {
            self.descriptionLabel.alpha = 1.0
            self.startButton.alpha = 1.0
        }, completion: { complete in
            self.startButton.isUserInteractionEnabled = true
        })
    }
    
    @objc private func start() {
        if roomCaptureView == nil {
            setupRoomCaptureView()
        }
        startSession()
    }
    
    @objc private func cancel() {
        stopSession()
        setActiveStartButtons()
    }
    
    @objc private func doneCapturing() {
        if isScanning {
            stopSession()
        } else {
            cancel()
        }
    }
}

// MARK: - Presenter output protocol

extension CameraViewController: CameraPresenterOutputProtocol {
    
}

// MARK: - Room Capture

extension CameraViewController: RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
    
    private func setupRoomCaptureView() {
        roomCaptureView = RoomCaptureView(frame: view.bounds)
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
        view.insertSubview(roomCaptureView, at: 0)
    }
    
    // Decide to post-process and show the final results.
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        return true
    }
    
    // Access the final post-processed results.
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
        
        var text = "number of walls \(processedResult.walls.count)"
        for wall in processedResult.walls {
            let newText = "dimension of wall - \(wall) - size \(wall.confidence)"
            text = text + newText
            print("square root \(wall.dimensions.squareRoot())")
            
        }
    }
}

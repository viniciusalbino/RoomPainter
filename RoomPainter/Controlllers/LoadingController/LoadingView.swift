//
//  LoadingView.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 14/01/23.
//

import Foundation
import UIKit

class LoadingView: UIView {
    private var loading: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    
    public override init(frame: CGRect) {
         super.init(frame: frame)
        setupView()
     }
     
     public required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setupView()
     }
    
    private func setupView() {
         addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.widthAnchor.constraint(equalToConstant: 44),
            loading.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func startLoading() {
        loading.startAnimating()
        loading.color = .black
        loading.hidesWhenStopped = true
    }
    
    func stopLoading() {
        loading.stopAnimating()
    }
}

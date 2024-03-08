//
//  SplashVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 4/3/2024.
//

import Foundation
import UIKit

protocol SceneDelegateDelegate: AnyObject {
    func changeRootViewController()
}


final class SplashVC: BaseViewController {
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    weak var delegate: SceneDelegateDelegate?
    
    private var contentView: SplashView {
        view as? SplashView ?? SplashView()
    }
    
    override func loadView() {
        view = SplashView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 3.0, animations: {
            self.contentView.progressViewWidthConstraint.constant = self.contentView.loadView.bounds.width
            self.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.delegate?.changeRootViewController()
        })
    }
}

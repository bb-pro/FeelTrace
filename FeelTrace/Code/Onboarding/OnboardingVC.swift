//
//  OnboardingVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 4/3/2024.
//

import UIKit

class OnboardingVC: BaseViewController {

    private var contentView: OnboardingView {
        view as? OnboardingView ?? OnboardingView()
    }
    
    override func loadView() {
        view = OnboardingView()
    }
    
    var currentPage = 0
}

//
//  OnboardingVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 4/3/2024.
//

import UIKit

class OnboardingVC: BaseViewController {

    var currentPage = 0
    
    var isNextEnabled = true {
        didSet {
            contentView.nextButton.actionButton.isEnabled = isNextEnabled
            if isNextEnabled {
                contentView.nextButton.containerview.backgroundColor = MyColors.tint.color
            } else {
                contentView.nextButton.containerview.backgroundColor = MyColors.secondary.color
            }
        }
    }

    private var contentView: OnboardingView {
        view as? OnboardingView ?? OnboardingView()
    }
    
    override func loadView() {
        view = OnboardingView()
        contentView.buttonStack.isHidden = true
        contentView.profileButtons.forEach { $0.button.addTarget(self, action: #selector(profileSelected(sender: )), for: .touchUpInside) }
        
        contentView.nameTF.field.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
        contentView.ageTF.field.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
        
        contentView.nextButton.actionButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func profileSelected(sender: UIButton) {
        contentView.profileButtons.forEach{ $0.backgroundColor = MyColors.secondary.color }
        contentView.profileButtons[sender.tag].backgroundColor = MyColors.tint.color
        isNextEnabled = true
    }
    
    @objc func textFieldChanged(sender: UITextField) {
        let nameText = contentView.nameTF.field.text ?? ""
        let ageText = contentView.ageTF.field.text ?? ""
        isNextEnabled = !nameText.isEmpty && !ageText.isEmpty
       
    }
    
    @objc func nextPressed() {
        currentPage += 1
        isNextEnabled = false
        if currentPage == 1 {
            contentView.customPageControl.setCurrentPage(index: currentPage)
            contentView.textFieldStack.isHidden = true
            contentView.buttonStack.isHidden = false
            contentView.nextButton.actionButton.isEnabled = false
        } else {
            
        }
    }
}

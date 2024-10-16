//
//  OnboardingVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 4/3/2024.
//

import UIKit

final class OnboardingVC: BaseViewController {

    var currentPage = 0
    
    var imageName = ""
    var categories: [Category] = []
    var name: String = ""
    var age: String = ""
    
    private let userDefaultsManager = UserDefaultsManager.shared

    private var contentView: OnboardingView {
        view as? OnboardingView ?? OnboardingView()
    }
    
    override func loadView() {
        view = OnboardingView()
        contentView.profileButtons.forEach { $0.button.addTarget(self, action: #selector(profileSelected(sender: )), for: .touchUpInside) }
        
        contentView.nameTF.field.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
        contentView.ageTF.field.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
        
        contentView.nextButton.actionButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        contentView.ageTF.field.keyboardType = .numberPad
        
        contentView.typeButtons.forEach { btn in
            btn.addTarget(self, action: #selector(categorySelected(sender: )), for: .touchUpInside)
        }
        
        contentView.skipBtn.addTarget(self, action: #selector(skipPressed), for: .touchUpInside)
        
        contentView.buttonStack.isHidden = true
        contentView.typeButtonStack.isHidden = true
        contentView.nextButton.actionButton.isEnabled = true
    }
    
    // MARK: - Actions
    @objc func profileSelected(sender: UIButton) {
        contentView.profileButtons.forEach{ $0.backgroundColor = MyColors.secondary.color }
        contentView.profileButtons[sender.tag].backgroundColor = MyColors.tint.color
        imageName = "profile\(sender.tag + 1)"
    }
    
    @objc func textFieldChanged(sender: UITextField) {
        let nameText = contentView.nameTF.field.text ?? ""
        let ageText = contentView.ageTF.field.text ?? ""
        name = nameText
        age = ageText
    }
    
    @objc func categorySelected(sender: UIButton) {
        sender.backgroundColor = MyColors.tint.color
        categories.append(Category.categories[sender.tag])
    }
    
    @objc func skipPressed() {
        presentTabBar()
       
        userDefaultsManager.saveOnboardingData(data: OnboardingData(
            imageName: imageName,
            categories: Array(Set(categories)),
            name: name,
            age: age))
    }
    
    @objc func nextPressed() {
        currentPage += 1
        if currentPage == 1 {
            contentView.textFieldStack.isHidden = true
            contentView.buttonStack.isHidden = false
        } else if currentPage == 2 {
            contentView.buttonStack.isHidden = true
            contentView.typeButtonStack.isHidden = false
        } else if currentPage == 3 {
            presentTabBar()
           
            userDefaultsManager.saveOnboardingData(data: OnboardingData(
                imageName: imageName,
                categories: Array(Set(categories)),
                name: name,
                age: age))
        }
        print(userDefaultsManager.getOnboardingData())
        contentView.customPageControl.setCurrentIndex(index: currentPage, progressColor: MyColors.tint.color)
    }
    
    private func presentTabBar() {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
}

//
//  AddArticleVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

protocol AddArticleVCDelegate: AnyObject {
    func addArticleVCDidDismiss()
}

final class AddArticleVC: BaseViewController {
    
    private let dataManager = CoreDataManager.shared
    
    private var contentView: AddArticleView {
        view as? AddArticleView ?? AddArticleView()
    }
    
    weak var delegate: AddArticleVCDelegate?
    
    override func loadView() {
        view = AddArticleView()
        
        contentView.saveBtn.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        contentView.titleTF.field.addTarget(self, action: #selector(textfieldChanged(sender: )), for: .allEvents)
        contentView.timeTF.field.addTarget(self, action: #selector(textfieldChanged(sender: )), for: .allEvents)
        
        contentView.fatigueSliderView.slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .allEvents)
        contentView.stressSliderView.slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .allEvents)
        contentView.intensitySliderView.slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .allEvents)
    }
    
    @objc func textfieldChanged(sender: UITextField) {
        // Handle textfield changes here
    }
    
    @objc func sliderChanged(sender: UISlider) {
        // Handle slider changes here
    }
    
    @objc func savePressed() {
        guard let title = contentView.titleTF.field.text,
              let time = contentView.timeTF.field.text
        else {
            return
        }
        let stressAmount = Double(contentView.stressSliderView.slider.value)
        let fatigueAmount = Double(contentView.fatigueSliderView.slider.value)
        let intensityAmount = Double(contentView.intensitySliderView.slider.value)
        
        let emotion = ""
        
        let date = Date()
        
        dataManager.createWorkout(title: title,
                                   time: time,
                                   stressAmount: stressAmount,
                                   fatigueAmount: fatigueAmount,
                                   intensityAmount: intensityAmount,
                                   emotion: emotion,
                                   date: date)
        dismiss(animated: true)
        delegate?.addArticleVCDidDismiss()
    }
    
}

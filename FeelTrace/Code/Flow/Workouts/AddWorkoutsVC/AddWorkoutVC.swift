//
//  AddArticleVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

protocol DismissDelegate: AnyObject {
    func dismiss()
}

final class AddWorkoutVC: BaseViewController {
    
    private let dataManager = CoreDataManager.shared
    private let emogis = ["😌", "😊", "😑", "😫", "😣"]
    private var selectedIndex = 0
    
    private var contentView: AddWorkoutView {
        return view as? AddWorkoutView ?? AddWorkoutView()
    }
    
    weak var delegate: DismissDelegate?
    var workout: Workout? // Property to hold workout data when editing
    
    override func loadView() {
        view = AddWorkoutView()
        
        contentView.saveBtn.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        contentView.titleTF.field.addTarget(self, action: #selector(textfieldChanged(sender: )), for: .allEvents)
        contentView.timeTF.field.addTarget(self, action: #selector(textfieldChanged(sender: )), for: .allEvents)
        
        contentView.fatigueSliderView.slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .allEvents)
        contentView.stressSliderView.slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .allEvents)
        contentView.intensitySliderView.slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .allEvents)
        contentView.emotionsView.buttons.forEach {($0.addTarget(self, action: #selector(emotionSelected(sender: )), for: .touchUpInside))}
        
        configureUI() // Configure UI based on whether workout data is provided
    }
    
    private func configureUI() {
        if let workout = workout {
            // Editing mode
            contentView.titleTF.field.text = workout.title
            contentView.timeTF.field.text = workout.time
            contentView.stressSliderView.slider.value = Float(workout.stressAmount)
            contentView.fatigueSliderView.slider.value = Float(workout.fatigueAmount)
            contentView.intensitySliderView.slider.value = Float(workout.intensityAmount)
            // Find the index of the emotion in the emogis array and select it
//            if let index = emogis.firstIndex(of: workout.emotion) {
//                selectedIndex = index
//                contentView.emotionsView.buttons[index].isSelected = true
//            }
            contentView.titleLabel.text = "Edit workout"
            contentView.saveBtn.setTitle("Update", for: .normal)
        } else {
            contentView.titleLabel.text = "Add workout"

            selectedIndex = 0 // Default to the first emotion
            contentView.saveBtn.setTitle("Save", for: .normal)
        }
    }
    
    @objc func emotionSelected(sender: UIButton) {
        selectedIndex = sender.tag
    }
    
    @objc func textfieldChanged(sender: UITextField) {
    }
    
    @objc func sliderChanged(sender: UISlider) {
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
        
        let emotion = emogis[selectedIndex]
        
        let date = Date()
        
        if let workout = workout {
            // Update mode
            dataManager.editWorkout(workout, title: title, time: time, stressAmount: stressAmount, fatigueAmount: fatigueAmount, intensityAmount: intensityAmount, emotion: emotion, date: date)
        } else {
            // Save mode
            dataManager.createWorkout(title: title,
                                      time: time,
                                      stressAmount: stressAmount,
                                      fatigueAmount: fatigueAmount,
                                      intensityAmount: intensityAmount,
                                      emotion: emotion,
                                      date: date)
        }
        
        dismissAllPresentedViewControllers()
        delegate?.dismiss()
    }
}

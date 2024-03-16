//
//  AddStatsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class AddStatsVC: BaseViewController {
    private var contentView: AddStatsView {
        return view as? AddStatsView ?? AddStatsView()
    }
    
    private let dataManager = CoreDataManager.shared

    weak var delegate: DismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = AddStatsView()
        setupUI()
        setupActions()
        observeTextFields()
        setupTapGestureRecognizer()
    }

    private func setupUI() {
        contentView.saveBtn.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        contentView.addAnotherBtn.addTarget(self, action: #selector(addAnotherStatsPressed), for: .touchUpInside)
    }

    private func setupActions() {
        contentView.timeSpentField.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.timeSpentField2.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.workoutTypeField.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.workoutTypeField2.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    private func observeTextFields() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textFieldDidChange() {
        let fieldsFilled = !contentView.timeSpentField.field.text!.isEmpty && !contentView.timeSpentField2.field.text!.isEmpty && !contentView.workoutTypeField.field.text!.isEmpty
    }

    // MARK: - Actions

    @objc func savePressed() {
        // Check if all required fields are filled
        guard let timeSpent1 = contentView.timeSpentField.field.text,
              let workoutType = contentView.workoutTypeField.field.text else
                    {
            return
        }
        let monthIndex = contentView.selectMonth(contentView.monthButton)
        let emotionIndex = contentView.emotionsView.selectedIndex

        dataManager.createStat(workoutType: workoutType, monthIndex: Int16(monthIndex), timeSpent: timeSpent1, emotionIndex: Int16(emotionIndex ?? 0))
        if contentView.timeSpentField2.field.text != "" {
            if let timeSpent2 = contentView.timeSpentField2.field.text,
               let workoutType2 = contentView.workoutTypeField2.field.text {
                print(timeSpent2)
                
                dataManager.createStat(workoutType: workoutType2, monthIndex: Int16(monthIndex), timeSpent: timeSpent2, emotionIndex: Int16(emotionIndex ?? 0))
            }
        }
        
        dismiss(animated: true)
        let data = dataManager.fetchAllStats()
        delegate?.dismiss()
        print(data.count)
        print(data)
    }


    @objc func addAnotherStatsPressed() {
        contentView.fieldStack2.isHidden = false
        contentView.addAnotherBtn.isHidden = true
    }

    // MARK: - Tap Gesture Recognizer

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        contentView.endEditing(true)
    }
}

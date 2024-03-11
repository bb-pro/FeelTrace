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

    override func viewDidLoad() {
        super.viewDidLoad()
        view = AddStatsView()
        setupUI()
        setupActions()
        observeTextFields()
    }

    private func setupUI() {
        contentView.saveBtn.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        contentView.addAnotherBtn.addTarget(self, action: #selector(addAnotherStatsPressed), for: .touchUpInside)
    }

    private func setupActions() {
        contentView.timeSpentField.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.timeSpentField2.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.workoutTypeField.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    private func observeTextFields() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textFieldDidChange() {
        let fieldsFilled = !contentView.timeSpentField.field.text!.isEmpty && !contentView.timeSpentField2.field.text!.isEmpty && !contentView.workoutTypeField.field.text!.isEmpty
        contentView.addAnotherBtn.isEnabled = fieldsFilled
    }

    // MARK: - Actions

    @objc func savePressed() {
        // Check if all required fields are filled
        guard let timeSpent1 = contentView.timeSpentField.field.text,
              let workoutType = contentView.workoutTypeField.field.text else
        {
            return
        }
        let monthIndex = contentView.monthMenu.tag
        let emotionIndex = contentView.selectMonth(contentView.monthButton)
        
        print(timeSpent1, workoutType, monthIndex, emotionIndex)

        // Save into Core Data
        dataManager.createStat(workoutType: workoutType, monthIndex: Int16(monthIndex), timeSpent: "\(timeSpent1)", emotionIndex: Int16(emotionIndex))


        dismiss(animated: true)
        let data = dataManager.fetchAllStats()
        print(data.count)
    }

    @objc func addAnotherStatsPressed() {
        contentView.fieldStack2.isHidden = false
        contentView.addAnotherBtn.isHidden = true
    }
}

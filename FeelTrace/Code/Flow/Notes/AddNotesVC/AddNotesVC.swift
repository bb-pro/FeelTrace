//
//  AddNotesVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class AddNotesVC: BaseViewController {

    private var contentView: AddNotesView {
        view as? AddNotesView ?? AddNotesView()
    }
    
    override func loadView() {
        view = AddNotesView()
        contentView.titleTF.field.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
        contentView.saveBtn.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            contentView.saveBtn.isEnabled = false
            return
        }
        contentView.saveBtn.isEnabled = true
    }
    
    @objc private func saveButtonPressed() {
        guard let title = contentView.titleTF.field.text, !title.isEmpty else {
            return
        }
        
        guard let noteText = contentView.noteTextView.text else { return  }
        let selectedDate = contentView.datePicker.date
        
        CoreDataManager.shared.createNote(title: title, date: selectedDate, noteText: noteText, isFavorite: false)
        
        dismissAllPresentedViewControllers()
    }
}


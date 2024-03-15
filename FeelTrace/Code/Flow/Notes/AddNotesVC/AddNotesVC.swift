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
    
    var note: WorkoutNote?
        
    override func loadView() {
        view = AddNotesView()
        contentView.titleTF.field.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
        contentView.saveBtn.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        configureUI()
    }
    
    private func configureUI() {
        guard let note = note else { return }
        contentView.titleTF.field.text = note.noteTitle
        contentView.datePicker.date = note.date ?? Date()
        contentView.noteTextView.text = note.note
        contentView.noteTextView.autocorrectionType = .no
        contentView.titleLabel.text = "Edit Note"
        contentView.saveBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
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
        
        if let note = note {
            CoreDataManager.shared.editNote(note, title: title, date:  selectedDate, noteText: noteText, isFavorite: false)
        } else {
            CoreDataManager.shared.createNote(title: title, date: selectedDate, noteText: noteText, isFavorite: false)
        }
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("ModalDismissedNotification"), object: nil)
        }
        dismissAllPresentedViewControllers()
    }
}


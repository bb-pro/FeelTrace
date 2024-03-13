//
//  NoteInfoVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class NoteInfoVC: BaseViewController {
    
    var note: WorkoutNote!
    
    private var contentView: NoteInfoView {
        view as? NoteInfoView ?? NoteInfoView()
    }
    
    override func loadView() {
        view = NoteInfoView()
        contentView.configure(with: note)
        contentView.starBtn.addTarget(self, action: #selector(starPressed), for: .touchUpInside)
        contentView.deleteBtn.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        contentView.saveBtn.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        
    }
    
    // MARK: - Actions
    @objc func starPressed() {
        CoreDataManager.shared.toggleNoteFavoriteStatus(note)
        contentView.starBtn.tintColor = note.isFavorite ? MyColors.tint.color : MyColors.black.color
//        contentView.starBtn.tintColor == note
    }
    
    @objc func deletePressed() {
        let alert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.confirmDelete()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func editPressed() {
        let alert = UIAlertController(title: "Edit Note", message: "Are you sure you want to edit this note?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Edit", style: .destructive) { [weak self] _ in
            self?.confirmEdit()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func confirmDelete() {
        CoreDataManager.shared.deleteNote(note)
//        dismiss(animated: true)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("ModalDismissedNotification"), object: nil)
        }
    }
    
    private func confirmEdit() {
        let editVC = AddNotesVC()
        editVC.note = note
        present(editVC, animated: true)
    }

}

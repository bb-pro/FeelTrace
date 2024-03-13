//
//  NotesVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class NotesVC: BaseViewController {
    
    private var contentView: NotesView {
        view as? NotesView ?? NotesView()
    }
    
    var showFavorites = false {
        didSet {
            if showFavorites {
                notes = CoreDataManager.shared.fetchAllNotes().filter { $0.isFavorite }
            } else {
                notes = CoreDataManager.shared.fetchAllNotes()
            }
            contentView.tableView.reloadData()
        }
    }
    
    private var notes = CoreDataManager.shared.fetchAllNotes() {
        didSet {
            contentView.centerStack.isHidden = !notes.isEmpty
        }
    }
    
    override func loadView() {
        view = NotesView()
        contentView.profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
        contentView.addButton.actionButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        contentView.addWorkoutBtn.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        notes = CoreDataManager.shared.fetchAllNotes()
        contentView.centerStack.isHidden = !notes.isEmpty
        contentView.allBtn.addTarget(self, action: #selector(categorySelected(sender: )), for: .touchUpInside)
        contentView.favoriteBtn.addTarget(self, action: #selector(categorySelected(sender: )), for: .touchUpInside)
        
        // Observe notifications for dismissals
        NotificationCenter.default.addObserver(self, selector: #selector(modalDismissed), name: NSNotification.Name(rawValue: "ModalDismissedNotification"), object: nil)
    }
    
    // MARK: - Actions
    
    @objc func categorySelected(sender: UIButton) {
        contentView.allBtn.backgroundColor = MyColors.secondary.color
        contentView.favoriteBtn.backgroundColor = MyColors.secondary.color
        if sender == contentView.allBtn {
            showFavorites = false
        } else {
            showFavorites = true
        }
        sender.backgroundColor = MyColors.tint.color
    }
    
    @objc func addPressed() {
        let addNoteVC = AddNotesVC()
        present(addNoteVC, animated: true)
    }
    
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
    
    // Called when modal view controller is dismissed
    @objc func modalDismissed() {
        notes = CoreDataManager.shared.fetchAllNotes()
        contentView.tableView.reloadData()
    }

    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITableViewDataSource and Delegate methods
extension NotesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.id, for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.configureUI(with: note)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let noteInfoVC = NoteInfoVC()
        noteInfoVC.note = note
        present(noteInfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
            let note = self?.notes[indexPath.row]
            let editVC = AddNotesVC()
            editVC.note = note
            self?.present(editVC, animated: true)
            completionHandler(true)
        }
        editAction.backgroundColor = MyColors.secondaryText.color
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let noteToDelete = self?.notes[indexPath.row] else { return }
            CoreDataManager.shared.deleteNote(noteToDelete)
            self?.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

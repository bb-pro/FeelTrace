//
//  NotesVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

import UIKit

final class NotesVC: BaseViewController, DismissDelegate {

    private var contentView: NotesView {
        view as? NotesView ?? NotesView()
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
    }
    
    // MARK: - Actions
    
    @objc func addPressed() {
        let addNoteVC = AddNotesVC()
        present(addNoteVC, animated: true)
    }
    
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
    
    func dismiss() {
       
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
            let note = self?.notes[indexPath.row]
            let noteInfoVC = NoteInfoVC()
            noteInfoVC.note = note
            self?.present(noteInfoVC, animated: true)
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

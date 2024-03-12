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
    }
}

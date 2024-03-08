//
//  WorkoutInfoVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 8/3/2024.
//

import UIKit

final class WorkoutInfoVC: BaseViewController {
    var workout: Workout!
    
    private var contentView: WorkoutInfoView {
        return view as? WorkoutInfoView ?? WorkoutInfoView()
    }

    override func loadView() {
        view = WorkoutInfoView()
        contentView.configure(with: workout)
        contentView.deleteBtn.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        contentView.editBtn.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func deletePressed() {
        
    }
    
    @objc func editPressed() {
        
    }

}

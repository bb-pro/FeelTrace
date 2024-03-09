//
//  AddStatsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class AddStatsVC: BaseViewController {

    private var contentView: AddStatsView {
        view as? AddStatsView ?? AddStatsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = AddStatsView()
        contentView.saveBtn.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc func savePressed() {
        dismiss(animated: true)
    }
}

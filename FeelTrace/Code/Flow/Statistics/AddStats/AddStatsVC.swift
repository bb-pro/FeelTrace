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

    }

}

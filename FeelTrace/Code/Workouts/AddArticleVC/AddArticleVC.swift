//
//  AddArticleVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

final class AddArticleVC: BaseViewController {

    private var contentView: AddArticleView {
        view as? AddArticleView ?? AddArticleView()
    }
    
    override func loadView() {
        view = AddArticleView()
    }
}

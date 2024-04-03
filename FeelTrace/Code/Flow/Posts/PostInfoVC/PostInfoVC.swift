//
//  PostInfoVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 13/3/2024.
//

import UIKit

final class PostInfoVC: BaseViewController {
    
    var post: Post!
    
    private var contentView: PostInfoView {
        view as? PostInfoView ?? PostInfoView()
    }
    
    override func loadView() {
        view = PostInfoView()
        
        contentView.configureUI(with: post)
        contentView.linkBtn.addTarget(self, action: #selector(linkPressed), for: .touchUpInside)
    }
    
    @objc func linkPressed() {
        let vc = WebViewController()
        vc.urltring = post.link
        present(vc, animated: true)
    }
}

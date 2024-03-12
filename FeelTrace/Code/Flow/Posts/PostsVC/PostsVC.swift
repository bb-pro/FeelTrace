//
//  PostsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 13/3/2024.
//

import UIKit

final class PostsVC: BaseViewController {
    private var contentView: PostView {
        view as? PostView ?? PostView()
    }
    
    private let posts = Post.getPosts()
    
    override func loadView() {
        view = PostView()
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self

    }
}

// MARK: - UITableViewDatasource and Delegate methods
extension PostsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as! PostCell
        cell.configureCell(with: posts[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let postInfoVC = PostInfoVC()
        postInfoVC.post = post
        present(postInfoVC, animated: true)
    }
    
}

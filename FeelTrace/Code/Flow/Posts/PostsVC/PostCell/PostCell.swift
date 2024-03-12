//
//  PostCell.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 13/3/2024.
//

import UIKit
import SnapKit

final class PostCell: UITableViewCell {

    static let id = String(describing: WorkoutCell.self)
    
    private lazy var postImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        return imgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 28)
        lbl.textColor = .black
        lbl.text = "Stretching"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 17)
        lbl.textColor = MyColors.secondaryText.color
        lbl.text = ""
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with post: Post) {
        postImageView.image = UIImage(named: post.image)
        titleLabel.text = post.title
        subTitleLabel.text = post.subtitle
    }
    
    private func setUpViews() {
        addSubview(postImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    private func setUpConstraints() {
        postImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

}

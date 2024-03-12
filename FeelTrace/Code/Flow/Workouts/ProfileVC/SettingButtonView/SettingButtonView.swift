//
//  SettingButtonView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class SettingButtonView: UIView {
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1
        view.layer.borderColor = MyColors.tint.color.cgColor
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(topLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(textLabel)
        addSubview(actionButton)
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(174)
            make.height.equalTo(150)
            make.left.right.bottom.top.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.width.equalTo(37)
            make.height.equalTo(41)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.bottom.equalTo(containerView.snp.bottom).offset(-16)
            
        }

        actionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setup(with item: ButtonDM) {
        containerView.backgroundColor = item.backColor
        containerView.layer.cornerRadius = 18
        textLabel.textColor = item.textColor
        textLabel.text = item.title
        if !item.icon.isEmpty {
            iconImageView.image = UIImage(named: item.icon)
            iconImageView.tintColor = item.textColor
        } else {
            iconImageView.image = nil
        }
    }

    
    // MARK: - Action
    
    @objc private func actionButtonTapped() {
        // Handle button tap action
    }
}

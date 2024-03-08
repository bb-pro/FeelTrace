//
//  CustomWorkoutProgressView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 8/3/2024.
//

import UIKit

class CustomWorkoutProgressView: UIView {
    // Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 15)
        label.textColor = MyColors.black.color
        return label
    }()
    
 
    private(set) lazy var progressControll: CustomPageControlView = {
        let controll = CustomPageControlView(numberOfIndicators: 10, currentIndex: 1, progressColor: MyColors.tint.color, width: 34, gap: 2)
        return controll
    }()
    
    private(set) lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 16)
        label.textColor = MyColors.secondaryText.color
        label.textAlignment = .left
        return label
    }()
    
    private lazy var maxAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 16)
        label.textColor = MyColors.secondaryText.color
        label.textAlignment = .right
        label.text = "10"
        return label
    }()
    
    // Initialization
    init(title: String) {
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
        
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up views
    private func setUpViews() {
        let bottomStack = UIStackView(arrangedSubviews: [amountLabel, maxAmountLabel])
        bottomStack.axis = .horizontal
        let stackView = UIStackView(arrangedSubviews: [titleLabel, progressControll, bottomStack])
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setup(progress: Int, color: UIColor) {
        progressControll.setCurrentIndex(index: progress - 1, progressColor: color)
        amountLabel.text = "\(progress)"
    }
    
    private func setUpConstraints() {
    }
    
}

//
//  CustomSliderView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

class CustomSliderView: UIView {
    // Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 15)
        label.textColor = MyColors.black.color
        return label
    }()
    
    private(set) lazy var slider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = MyColors.tint.color
        slider.tintColor = MyColors.tint.color
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, slider, bottomStack])
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    // Set up constraints
    private func setUpConstraints() {
    }
    
    // Slider value changed action
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value * 10)
        amountLabel.text = "\(value)"
    }
}

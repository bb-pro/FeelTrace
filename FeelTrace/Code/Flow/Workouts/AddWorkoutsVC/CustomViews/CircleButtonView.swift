//
//  CircleButtonView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit
import SnapKit

class CircleButtonView: UIView {
    
    var buttonTapped: ((String) -> Void)?
    private(set) var buttons = [UIButton]()
    private var selectedIndex: Int?
    
    private let buttonTitles: [String]
    private let buttonSize: CGFloat = 44
    
    init(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = index
            button.titleLabel?.font = .customSFFont(.regular, size: 28)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button.layer.cornerRadius = buttonSize / 2
            button.clipsToBounds = true
            buttons.append(button)
            
            addSubview(button)
            
            button.snp.makeConstraints { make in
                make.width.height.equalTo(buttonSize)
//                make.centerY.equalToSuperview()
                
//                if index == 0 {
//                    make.leading.equalToSuperview()
//                } else {
//                    make.leading.equalTo(buttons[index - 1].snp.trailing).offset(8)
//                }
            }
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        buttonTapped?(title)
        
        selectedIndex = sender.tag
        updateButtonBackground()
    }
    
    private func updateButtonBackground() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.backgroundColor = MyColors.tint.color
            } else {
                button.backgroundColor = .clear
            }
        }
    }
}

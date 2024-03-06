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
    
    private let buttonTitles: [String]
    private let circleSize: CGFloat = 44
    
    init(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            buttons.append(button)
            
            let circleView = UIView()
            circleView.backgroundColor = .clear
            circleView.layer.cornerRadius = circleSize / 2
            circleView.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(circleView)
            addSubview(button)
            
            circleView.snp.makeConstraints { make in
                make.width.height.equalTo(circleSize)
                make.centerY.equalTo(button.snp.centerY)
                make.leading.equalToSuperview()
            }
            
            button.snp.makeConstraints { make in
                make.leading.equalTo(circleView.snp.trailing).offset(8)
                make.trailing.top.bottom.equalToSuperview()
            }
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        buttonTapped?(title)
    }
}

//
//  ProfileButtonView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import UIKit

final class ProfileButtonView: UIView {
    
    let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let size: CGFloat = 174
        self.snp.makeConstraints { make in
            make.height.width.equalTo(size)
        }
        self.layer.cornerRadius = size / 2
        
        self.backgroundColor = MyColors.secondary.color
        
        
        button.frame = self.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setImage(.profile1, for: .normal)
        self.addSubview(button)
    }
    
    @objc private func buttonTapped() {
        print("Button tapped!")
    }
    
    
}

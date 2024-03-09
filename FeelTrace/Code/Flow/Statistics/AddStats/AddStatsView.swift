//
//  AddStatsView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class AddStatsView: UIView {
    
    // MARK: - Properties
    
    private lazy var topImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = .grabber
        return imgView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add workout"
        label.textColor = MyColors.black.color
        label.font = .customSFFont(.regular, size: 15)
        return label
    }()
    
    private(set) lazy var saveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private lazy var emotionsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 15)
        lbl.textColor = MyColors.black.color
        lbl.text = "Emotions"
        return lbl
    }()
    
    lazy var emotionsView = CircleButtonView(buttonTitles: emojis)
    
    private lazy var emotionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 32
        emotionsView.buttons.forEach { btn in
            stack.addArrangedSubview(btn)
        }
        return stack
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(topImgView)
        addSubview(saveBtn)
        addSubview(emotionsLabel)
        addSubview(emotionsStack)
    }
    
    func setUpConstraints() {
        topImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topImgView.snp.bottom).offset(16)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        emotionsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(16)
        }
        
        emotionsStack.snp.makeConstraints { make in
            make.top.equalTo(emotionsLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}

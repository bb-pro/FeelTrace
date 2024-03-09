//
//  AddArticleView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

let emojis = ["😌", "😊", "😑", "😫", "😣"]

final class AddWorkoutView: UIView {
    
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
        btn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private(set) lazy var titleTF: CustomTextFieldView = {
        let titleTF = CustomTextFieldView()
        titleTF.field.placeholder = "Title"
        return titleTF
    }()
    
    private(set) lazy var timeTF: CustomTextFieldView = {
        let timeTF = CustomTextFieldView()
        timeTF.field.placeholder = "Duration"
        return timeTF
    }()
    
    private lazy var mainStackView: UIStackView = {
        let topStackView = UIStackView(arrangedSubviews: [titleTF, timeTF, fatigueSliderView, stressSliderView, intensitySliderView, emotionsTitle, emotionsStack])
        topStackView.axis = .vertical
        topStackView.spacing = 16
        topStackView.alignment = .fill
        return topStackView
    }()
    
    private(set) lazy var fatigueSliderView: CustomSliderView = {
        let sliderView = CustomSliderView(title: "Fatigue (1 - I’m okay, 10 - I’m exhausted)")
        return sliderView
    }()
    
    private(set) lazy var stressSliderView: CustomSliderView = {
        let sliderView = CustomSliderView(title: "Stress (1 - I’m okay, 10 - I’m feeling very stressed)")
        return sliderView
    }()
    
    private(set) lazy var intensitySliderView: CustomSliderView = {
        let sliderView = CustomSliderView(title: "Intensity (1 - Okay, 10 - It was very hard)")
        return sliderView
    }()
    
    private lazy var emotionsTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 15)
        lbl.text = "Emotions"
        lbl.textColor = MyColors.black.color
        return lbl
    }()
    
    lazy var emotionsView = CircleButtonView(buttonTitles: ["😌", "😊", "😑", "😫", "😣"])
    
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
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(topImgView)
        addSubview(titleLabel)
        addSubview(saveBtn)
        addSubview(mainStackView)
    }
    
    private func setUpConstraints() {
        
        topImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topImgView.snp.bottom).offset(16)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-16)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

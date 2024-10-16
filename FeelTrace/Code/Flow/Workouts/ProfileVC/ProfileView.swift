//
//  ProfileView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

final class ProfileView: UIView {
    
    private let onboardingData = UserDefaultsManager.shared.getOnboardingData()
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 15)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Profile"
        return label
    }()
    
    private(set) lazy var editButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imgView = UIImageView()
        if onboardingData.imageName == "" {
            imgView.image = nil
        } else {
            imgView.image = UIImage(named: onboardingData.imageName)
        }
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        imgView.backgroundColor = MyColors.tint.color
        imgView.layer.cornerRadius = 40
        return imgView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "\(onboardingData.name), \(onboardingData.age)"
        return label
    }()
    
    private(set) lazy var shareView: SettingButtonView = {
        let view = SettingButtonView()
        view.setup(
            with:ButtonDM(
                        icon: "setting1",
                        title: "Share app",
                        textColor: MyColors.tint.color,
                        backColor: .clear))
        return view
    }()
    
    private(set) lazy var rateView: SettingButtonView = {
        let view = SettingButtonView()
        view.setup(
            with:ButtonDM(
                        icon: "setting2",
                        title: "Rate app",
                        textColor: MyColors.tint.color,
                        backColor: .clear))
        return view
    }()
    
    private(set) lazy var usageProfileView: SettingButtonView = {
        let view = SettingButtonView()
        view.setup(
            with:ButtonDM(
                        icon: "setting3",
                        title: "Usage profile",
                        textColor: MyColors.tint.color,
                        backColor: .clear))
        return view
    }()
    
    private(set) lazy var resetView: SettingButtonView = {
        let view = SettingButtonView()
        view.setup(
            with:ButtonDM(
                        icon: "setting4",
                        title: "Reset progress",
                        textColor: MyColors.tint.color,
                        backColor: .clear))
        return view
    }()
    
    private lazy var settingsStack: UIStackView = {
        let topStackView = UIStackView(arrangedSubviews: [shareView, rateView])
        topStackView.axis = .horizontal
        topStackView.spacing = 16
        let bottomStackView = UIStackView(arrangedSubviews: [usageProfileView, resetView])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 16
        
        let mainStack = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        return mainStack
    }()
    
    private(set) lazy var typeButtonStack: UIStackView = createButtonStack()
    
    lazy var typeButtons: [UIButton] = createTypeButtons()
    
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
        addSubview(titleLabel)
        addSubview(editButton)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(typeButtonStack)
        addSubview(settingsStack)
    }
    
    func setUpConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        editButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.height.width.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        typeButtonStack.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        settingsStack.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            make.left.equalToSuperview().offset(16)
        }
    }
    
    private func createTypeButtons() -> [UIButton] {
        var buttons = [UIButton]()
        for index in 0..<onboardingData.categories.count {
            let category = onboardingData.categories[index]
            let button = UIButton(type: .custom)
            button.isUserInteractionEnabled = true
            button.tag = index
            button.layer.cornerRadius = 19
            button.backgroundColor = MyColors.tint.color
            button.snp.makeConstraints { make in
                make.height.equalTo(36)
                make.width.equalTo(category.width)
            }
            button.setTitle(category.type, for: .normal)
            buttons.append(button)
            
        }
        return buttons
    }
    
    private func createButtonStack() -> UIStackView {
        let buttons = typeButtons
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        let buttonCount = buttons.count
        let buttonsPerRow = 3
        
        var startIndex = 0
        while startIndex < buttonCount {
            let endIndex = min(startIndex + buttonsPerRow, buttonCount)
            let rowButtons = Array(buttons[startIndex..<endIndex])
            
            let horizontalStack = UIStackView(arrangedSubviews: rowButtons)
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 8
            horizontalStack.alignment = .center
            stackView.addArrangedSubview(horizontalStack)
            
            startIndex += buttonsPerRow
        }
        
        return stackView
    }

}

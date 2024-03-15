//
//  AddStatsView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit
import UIKit
import SnapKit

final class AddStatsView: UIView {
    
    // MARK: - Properties
    
    private lazy var topImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "grabber")
        return imgView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add statistics"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private(set) lazy var saveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var emotionsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.text = "Emotions"
        return lbl
    }()
    
    lazy var emotionsView = CircleButtonView(buttonTitles: emojis) // Assuming emojis is an array of strings
    
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
    
    private(set) lazy var monthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose month", for: .normal)
        button.addTarget(self, action: #selector(showMonthMenu), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private(set) lazy var monthMenu: UIView = {
        let menuView = UIView()
        menuView.backgroundColor = .white
        menuView.layer.cornerRadius = 8
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 0.3
        menuView.layer.shadowOffset = CGSize(width: 0, height: 2)
        menuView.layer.shadowRadius = 4
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(stackView)
        
        for (index, monthName) in months.enumerated() {
            let monthButton = UIButton(type: .system)
            monthButton.setTitle(monthName, for: .normal)
            monthButton.addTarget(self, action: #selector(selectMonth(_:)), for: .touchUpInside)
            monthButton.tag = index
            stackView.addArrangedSubview(monthButton)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        menuView.sizeToFit()
        
        return menuView
    }()

    
    private(set) lazy var addAnotherBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = MyColors.tint.color
        btn.tintColor = .white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("Add another workout", for: .normal)
        btn.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(185)
        }
        btn.layer.cornerRadius = 18
        return btn
    }()
    
    private(set) lazy var fieldStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [workoutTypeField, timeSpentField])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) lazy var workoutTypeField: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.field.placeholder = "Type of workout"
        return view
    }()
    
    private(set) lazy var timeSpentField: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.field.placeholder = "Time spent"
        view.field.keyboardType = .numberPad
        return view
    }()
    
    private(set) lazy var fieldStack2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [workoutTypeField2, timeSpentField2])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isHidden = true
        return stackView
    }()
    
    private(set) lazy var workoutTypeField2: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.field.placeholder = "Type of workout"
        return view
    }()
    
    private(set) lazy var timeSpentField2: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.field.placeholder = "Time spent"
        view.field.keyboardType = .numberPad
        return view
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
        addSubview(monthButton) // Add month button to the view
        addSubview(addAnotherBtn)
        addSubview(fieldStack)
        addSubview(fieldStack2)
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
            make.height.width.equalTo(30)
        }
        
        emotionsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(16)
        }
        
        emotionsStack.snp.makeConstraints { make in
            make.top.equalTo(emotionsLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        monthButton.snp.makeConstraints { make in
            make.top.equalTo(emotionsStack.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(63)
        }
        
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        addAnotherBtn.snp.makeConstraints { make in
            make.top.equalTo(fieldStack.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        fieldStack2.snp.makeConstraints { make in
            make.top.equalTo(addAnotherBtn.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Actions
    
    @objc private func showMonthMenu() {
        addSubview(monthMenu)
        monthMenu.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(8)
            make.leading.equalTo(monthButton.snp.leading)
        }
    }
    
    @objc func selectMonth(_ sender: UIButton) -> Int {
        guard let title = sender.titleLabel?.text,
              let index = months.firstIndex(of: title) else { return 0 }
        
        print("Selected month: \(title), Index: \(index)")
        
        monthButton.setTitle(title, for: .normal)
        monthMenu.removeFromSuperview()
        return index
    }

}

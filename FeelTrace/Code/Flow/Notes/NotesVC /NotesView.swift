//
//  NotesView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class NotesView: UIView {
    
    let onboardingData = UserDefaultsManager.shared.getOnboardingData()
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Notes"
        return label
    }()
    
    private(set) lazy var allBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = MyColors.tint.color
        btn.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(61)
        }
        btn.setTitle("All", for: .normal)
        btn.titleLabel?.font = .customSFFont(.regular, size: 15)
        btn.tintColor = MyColors.white.color
        btn.layer.cornerRadius = 18
        return btn
    }()
    
    private(set) lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = MyColors.secondary.color
        btn.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(98)
        }
        btn.setTitle("Favorite", for: .normal)
        btn.titleLabel?.font = .customSFFont(.regular, size: 15)
        btn.tintColor = MyColors.white.color
        btn.layer.cornerRadius = 18
        return btn
    }()
    
    private lazy var topStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [allBtn, favoriteBtn])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) lazy var profileButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: onboardingData.imageName), for: .normal)
        btn.backgroundColor = MyColors.tint.color
        btn.layer.cornerRadius = 22
        return btn
    }()
    
    private(set) lazy var addButton: CustomButtonView = {
        let view = CustomButtonView()
        view.btnUpdate(item: ButtonDM(
            icon: "",
            title: "Add",
            textColor: MyColors.white.color,
            backColor: MyColors.tint.color))
        view.snp.makeConstraints { make in
            make.height.equalTo(63)
        }
        return view
    }()
    
    private(set) lazy var emptyFavoriteStack: UIStackView = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "There’s nothing to look at!"
        
        let subLabel = UILabel()
        subLabel.font = .customSFFont(.regular, size: 15)
        subLabel.textColor = MyColors.black.color
        subLabel.textAlignment = .center
        subLabel.text = "You can mark notes as favorite in a note card"
        
        let stackView = UIStackView(arrangedSubviews: [label, subLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.isHidden = true
        return stackView
    }()
    
    private(set) lazy var centerStack: UIStackView = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Add your first note"
        
        let stackView = UIStackView(arrangedSubviews: [label, addButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private(set) lazy var addWorkoutBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = MyColors.tint.color
        btn.setTitle("Add note", for: .normal)
        btn.setTitleColor(MyColors.white.color, for: .normal)
        btn.layer.cornerRadius = 18
        return btn
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.id)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
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
    
    private func setUpViews() {
        addSubview(profileButton)
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(centerStack)
        addSubview(topStack)
        addSubview(addWorkoutBtn)
        addSubview(emptyFavoriteStack)
    }
    
    private func setUpConstraints() {
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.left.equalToSuperview().offset(16)
        }
        
        centerStack.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        emptyFavoriteStack.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        addWorkoutBtn.snp.makeConstraints { make in
            make.right.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(36)
            make.width.equalTo(129)
        }
        
        topStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
}

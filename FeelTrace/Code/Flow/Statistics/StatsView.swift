//
//  StatsView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

protocol StatsViewDelegate: AnyObject {
    func selectedMonth(indexPath: IndexPath)
}

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

final class StatsView: UIView {
    
    let onboardingData = UserDefaultsManager.shared.getOnboardingData()
    var selectedIndexPath: IndexPath? // Variable to keep track of the selected index
    
    // MARK: - Elements
    
    weak var delegate: StatsViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Statistics"
        return label
    }()
    
    private(set) lazy var profileButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: onboardingData.imageName), for: .normal)
        btn.backgroundColor = MyColors.tint.color
        btn.layer.cornerRadius = 22
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StatsCell.self, forCellWithReuseIdentifier: "StatsCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private(set) lazy var workout1View: SettingButtonView = {
        let view = SettingButtonView()
        view.iconImageView.isHidden = true
        return view
    }()
    
    private(set) lazy var workout2View: SettingButtonView = {
        let view = SettingButtonView()
        view.iconImageView.isHidden = true
        view.containerView.backgroundColor = MyColors.tint.color
        return view
    }()
    
    private(set) lazy var workout3View: SettingButtonView = {
        let view = SettingButtonView()
        view.containerView.backgroundColor = MyColors.tint.color
        return view
    }()
    
    private(set) lazy var workout4View: SettingButtonView = {
        let view = SettingButtonView()
        view.iconImageView.isHidden = true
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let topStack = UIStackView(arrangedSubviews: [workout1View, workout2View])
        topStack.axis = .horizontal
        topStack.spacing = 16
        
        let bottomStack = UIStackView(arrangedSubviews: [workout3View, workout4View])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 16
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        
        return mainStack
    }()
    
    private(set) lazy var addStatsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = MyColors.tint.color
        button.layer.cornerRadius = 18
        button.tintColor = MyColors.white.color
        button.setTitle("Add statistics", for: .normal)
        button.titleLabel?.font = UIFont.customSFFont(.regular, size: 15) 
        return button
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
        addSubview(collectionView)
        addSubview(mainStack)
        addSubview(addStatsButton)
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        addStatsButton.snp.makeConstraints { make in
            make.width.equalTo(135)
            make.height.equalTo(36)
            make.right.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
}

extension StatsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsCell", for: indexPath) as! StatsCell
        cell.titleLabel.text = months[indexPath.row]
        cell.layer.cornerRadius = 18
        if indexPath == selectedIndexPath {
            cell.backgroundColor = MyColors.tint.color
        } else {
            cell.backgroundColor = MyColors.secondary.color
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 98, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Update selectedIndexPath
        selectedIndexPath = indexPath
        // Reload the collection view to reflect changes in cell appearance
        collectionView.reloadData()
        // Notify the delegate of the selected month
        delegate?.selectedMonth(indexPath: indexPath)
    }
}

final class StatsCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.font = .customSFFont(.regular, size: 15)
        titleLabel.textColor = MyColors.white.color
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

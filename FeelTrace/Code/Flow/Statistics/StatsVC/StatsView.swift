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
    var workoutData: [Workout] = [] // Assume Workout is your data model
    
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
        collectionView.register(MonthCell.self, forCellWithReuseIdentifier: "MonthCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var workoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 174, height: 150)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StatsCell.self, forCellWithReuseIdentifier: "StatsCell")
        collectionView.showsVerticalScrollIndicator = true
        return collectionView
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
    
    private(set) lazy var centerStack: UIStackView = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Add your first month experience"
        
        let stackView = UIStackView(arrangedSubviews: [label, addButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
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
        addSubview(workoutCollectionView)
        addSubview(addStatsButton)
        addSubview(centerStack)
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
        
        workoutCollectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        addStatsButton.snp.makeConstraints { make in
            make.width.equalTo(135)
            make.height.equalTo(36)
            make.right.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        centerStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

extension StatsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return months.count
        } else {
            return workoutData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCell", for: indexPath) as! MonthCell
            cell.titleLabel.text = months[indexPath.row]
            cell.layer.cornerRadius = 18
            if indexPath == selectedIndexPath {
                cell.backgroundColor = MyColors.tint.color
            } else {
                cell.backgroundColor = MyColors.secondary.color
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsCell", for: indexPath) as! StatsCell
            // Configure the cell with your workout data
            // Assuming workoutData contains Workout objects
//            let workout = workoutData[indexPath.item]
//            cell.workoutView.titleLabel.text = workout.title
//            cell.workoutView.iconImageView.image = UIImage(named: workout.iconName)
            // Configure other properties of workout view if needed
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: 98, height: 36)
        } else {
            return CGSize(width: 174, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            selectedIndexPath = indexPath
            collectionView.reloadData()
            delegate?.selectedMonth(indexPath: indexPath)
        } else {
            // Handle selection of workout cell if needed
        }
    }
}

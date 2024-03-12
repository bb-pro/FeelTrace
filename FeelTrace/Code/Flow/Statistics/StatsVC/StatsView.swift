//
//  StatsView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

import UIKit
import CoreData

protocol StatsViewDelegate: AnyObject {
    func selectedMonth(indexPath: IndexPath)
}

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

final class StatsView: UIView {
    
    let onboardingData = UserDefaultsManager.shared.getOnboardingData()
    var selectedIndexPath: IndexPath? // Variable to keep track of the selected index
    var allStats: [Stats] = CoreDataManager.shared.fetchAllStats() {
        didSet {
            centerStack.isHidden = !allStats.isEmpty
        }
    }
    
    var selectedMonthIndex: Int16? {
        didSet {
            filterStatsByMonth()
        }
    }
    var filteredStats: [Stats] = CoreDataManager.shared.fetchAllStats() {
        didSet {
            centerStack.isHidden = !filteredStats.isEmpty
            workoutCollectionView.reloadData()
        }
    }
    
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
    
    private(set) lazy var collectionView: UICollectionView = {
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
    
    private(set) lazy var workoutCollectionView: UICollectionView = {
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
        fetchAllStatsFromCoreData()
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
    
    func calculateRecentEmotionAndTime() -> (emotionIndex: Int, totalTime: Int) {
        var emotionCount = Array(repeating: 0, count: emojis.count)
        var totalTimeSpent = 0
        
        for stat in filteredStats {
            emotionCount[Int(stat.emotionIndex)]
            totalTimeSpent += Int(stat.timeSpent ?? "0") ?? 0
        }
        
        guard let maxIndex = emotionCount.enumerated().max(by: { $0.element < $1.element })?.offset else {
            return (0, totalTimeSpent)
        }
        
        return (maxIndex, totalTimeSpent)
    }

    // MARK: - Core Data
    
    private func fetchAllStatsFromCoreData() {
        allStats = CoreDataManager.shared.fetchAllStats()
        print(allStats)
    }
    
    func refreshData() {
        allStats = CoreDataManager.shared.fetchAllStats()
        
        filterStatsByMonth()
        
        workoutCollectionView.reloadData()
    }
    
    // MARK: - Filtering
    
    private func filterStatsByMonth() {
        if let selectedMonthIndex = selectedMonthIndex {
            filteredStats = allStats.filter { $0.monthIndex == selectedMonthIndex }
        } else {
            filteredStats = allStats
        }
    }
    
    func configureStatsCell(cell: StatsCell, indexPath: IndexPath) {
        if indexPath.row < filteredStats.count {
            let stat = filteredStats[indexPath.row]
            if indexPath.row % 4 == 0 {
                cell.configure(stats: stat, background: MyColors.white.color, tintcolor: MyColors.tint.color)
            } else if indexPath.row % 4 == 1 || indexPath.row % 4 == 2 {
                cell.configure(stats: stat, background: MyColors.tint.color, tintcolor: MyColors.white.color)
            } else {
                cell.workoutView.containerView.backgroundColor = MyColors.white.color
            }
        } else if indexPath.row == filteredStats.count {
            let (emotionIndex, totalTimeSpent) = calculateRecentEmotionAndTime()
            cell.workoutView.topLabel.text = emojis[emotionIndex]
            cell.workoutView.textLabel.text = "Emotions"
        } else {
            let (emotionIndex, totalTimeSpent) = calculateRecentEmotionAndTime()
//            cell.workoutView.topLabel.text = emojis[emotionIndex]
            cell.workoutView.topLabel.text = "\((Float(totalTimeSpent) / 60).rounded())"
            print("hours spent")
            print(totalTimeSpent/60)
            cell.workoutView.textLabel.text = "hours spent"
        }
    }
}

extension StatsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return months.count
        } else {
            if !filteredStats.isEmpty {
                return filteredStats.count + 2
            } else {
                return 0
            }
            
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
            configureStatsCell(cell: cell, indexPath: indexPath)
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
            selectedMonthIndex = Int16(indexPath.row)
            collectionView.reloadData()
            delegate?.selectedMonth(indexPath: indexPath)
        } else {
        }
    }
}

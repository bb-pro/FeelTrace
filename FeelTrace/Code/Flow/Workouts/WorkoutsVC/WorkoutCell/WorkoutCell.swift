//
//  WorkoutCell.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit

final class WorkoutCell: UITableViewCell {
    
    static let id = String(describing: WorkoutCell.self)
    
    // MARK: - Элементы
    private(set) lazy var backgroundContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 22)
        lbl.textColor = .black
        lbl.text = "Stretching"
        return lbl
    }()
    
    private lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 22)
        lbl.textColor = MyColors.secondaryText.color
        lbl.text = "22.01.2024"
        return lbl
    }()
    
    private lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 34)
        lbl.textColor = MyColors.tint.color
        lbl.textAlignment = .right
        lbl.text = "30 min"
        return lbl
    }()
    
    private lazy var emotionsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 20)
        lbl.textColor = MyColors.black.color
        lbl.text = "Emotions"
        return lbl
    }()
    
    private lazy var emotionsAmount: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 20)
        lbl.textColor = MyColors.black.color
        return lbl
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = MyColors.tint.color
        view.snp.makeConstraints { make in
            make.height.equalTo(0.5)
        }
        return view
    }()
    
    private lazy var stressTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 15)
        lbl.textColor = MyColors.black.color
        lbl.text = "Stress"
        return lbl
    }()
    
    private lazy var fatigueTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 15)
        lbl.textColor = MyColors.black.color
        lbl.text = "Fatigue"
        return lbl
    }()
    
    private lazy var intensityTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 15)
        lbl.textColor = MyColors.black.color
        lbl.text = "Intensity"
        return lbl
    }()
    
    private lazy var stressAmount: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 20)
        lbl.textColor = MyColors.black.color
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var fatigueAmount: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 20)
        lbl.textColor = MyColors.black.color
        lbl.numberOfLines = 0
        return lbl
    }()

    private lazy var intensityAmount: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 20)
        lbl.textColor = MyColors.black.color
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var mainStack: UIStackView = {
        let stretchingStack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stretchingStack.axis = .vertical
        stretchingStack.spacing = 4
        
        let topStack = UIStackView(arrangedSubviews: [stretchingStack, timeLabel])
        topStack.axis = .horizontal
        topStack.distribution = .fill
        
        let stack1 = UIStackView(arrangedSubviews: [emotionsLabel, emotionsAmount])
        stack1.axis = .vertical
        stack1.spacing = 8
        stack1.alignment = .leading
        
        let stack2 = UIStackView(arrangedSubviews: [stressTitle, stressAmount])
        stack2.axis = .vertical
        stack2.spacing = 8
        stack2.alignment = .center
        
        let stack3 = UIStackView(arrangedSubviews: [fatigueTitle, fatigueAmount])
        stack3.axis = .vertical
        stack3.spacing = 8
        stack3.alignment = .center
        
        let stack4 = UIStackView(arrangedSubviews: [intensityTitle, intensityAmount])
        stack4.axis = .vertical
        stack4.spacing = 8
        stack4.alignment = .center
        
        let bottomStack = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 16
        bottomStack.alignment = .leading
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, separatorView, bottomStack])
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.spacing = 16
        return mainStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func configure(with workout: Workout) {
        titleLabel.text = workout.title
        timeLabel.text = workout.time
        emotionsAmount.text = workout.emotion
        stressAmount.text = "\(Int(workout.stressAmount * 10))/10"
        fatigueAmount.text = "\(Int(workout.fatigueAmount * 10))/10"
        intensityAmount.text = "\(Int(workout.intensityAmount * 10))/10"
        dateLabel.text = workout.date?.toString()
    }
    
    func setUpViews() {
        backgroundContentView.addSubview(mainStack)
        addSubview(backgroundContentView)
    }
    
    func setUpConstraints() {
        mainStack.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        backgroundContentView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

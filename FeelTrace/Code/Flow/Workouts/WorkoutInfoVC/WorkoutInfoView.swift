//
//  WorkoutInfoView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 8/3/2024.
//

import UIKit

final class WorkoutInfoView: UIView {
    
    // MARK: - Properties
    
    private lazy var topImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = .grabber
        return imgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add workout"
        label.textColor = MyColors.black.color
        label.font = .customSFFont(.regular, size: 15)
        return label
    }()
    
    private(set) lazy var editBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private(set) lazy var deleteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.tintColor = .red
        return btn
    }()
    
    private lazy var workoutLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 22)
        lbl.textColor = .black
        lbl.text = "Stretching"
        return lbl
    }()
    
    private lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 17)
        lbl.textColor = MyColors.secondaryText.color
        lbl.text = "22.01.2024"
        return lbl
    }()
    
    private lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 17)
        lbl.textColor = MyColors.tint.color
        lbl.textAlignment = .left
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
        lbl.text = "🤓"
        return lbl
    }()
    
    private(set) lazy var fatigueView: CustomWorkoutProgressView = {
        let view = CustomWorkoutProgressView(title: "Fatigue")
        return view
    }()
    
    private(set) lazy var stressView: CustomWorkoutProgressView = {
        let view = CustomWorkoutProgressView(title: "Stress")
        return view
    }()
    
    private(set) lazy var intensityView: CustomWorkoutProgressView = {
        let view = CustomWorkoutProgressView(title: "Intensity")
        return view
    }()
    
    private(set) lazy var mainStack: UIStackView = {
        let dateStack = UIStackView(arrangedSubviews: [dateLabel, timeLabel])
        dateStack.axis = .vertical
        let emotionStack = UIStackView(arrangedSubviews: [emotionsLabel, emotionsAmount])
        emotionStack.alignment = .trailing
        emotionStack.axis = .vertical
        let topStack = UIStackView(arrangedSubviews: [dateStack, emotionStack])
        let stack = UIStackView(arrangedSubviews: [topStack, fatigueView, stressView, intensityView])
        stack.axis = .vertical
        stack.spacing = 32
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
    
    func setUpViews() {
        addSubview(topImgView)
        addSubview(deleteBtn)
        addSubview(editBtn)
        addSubview(workoutLabel)
        addSubview(mainStack)
    }
    
    func setUpConstraints() {
        topImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        editBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-16)
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        workoutLabel.snp.makeConstraints { make in
            make.top.equalTo(deleteBtn.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(workoutLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with workout: Workout) {
        workoutLabel.text = workout.title
        dateLabel.text = workout.date?.toString()
        timeLabel.text = workout.time
        emotionsAmount.text = workout.emotion
        fatigueView.setup(progress: workout.fatigueAmount.toInt(), color: MyColors.tint.color)
        stressView.setup(progress: workout.stressAmount.toInt(), color: MyColors.green.color)
        intensityView.setup(progress: workout.intensityAmount.toInt(), color: MyColors.green.color)
    }
}

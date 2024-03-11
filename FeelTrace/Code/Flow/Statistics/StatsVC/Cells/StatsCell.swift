//
//  StatsCell.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class StatsCell: UICollectionViewCell {
    
    lazy var workoutView: SettingButtonView = {
        let view = SettingButtonView()
        view.iconImageView.isHidden = true
        view.containerView.backgroundColor = MyColors.tint.color
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(workoutView)
        workoutView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with stats: Stats) {
        // Assuming the 'workoutType' and 'timeSpent' properties are optional
        workoutView.setup(with: ButtonDM(icon: "", title: stats.workoutType ?? "", textColor: MyColors.tint.color, backColor: MyColors.white.color))
    }
}

//
//  CustomPageControlView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import UIKit

final class CustomPageControlView: UIView {
    
    private let numberOfPages = 3
    private let width: CGFloat = 40
    private let height: CGFloat = 4
    private let indicatorSpacing: CGFloat = 8
    private var indicatorViews = [UIView]()
    private var currentIndex = 0
    
    init() {
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = indicatorSpacing
        addSubview(stackView)
        
        for index in 0..<numberOfPages {
            let indicatorView = UIView()
            indicatorView.backgroundColor = index == 0 ? MyColors.tint.color : MyColors.secondaryText.color
            stackView.addArrangedSubview(indicatorView)
            indicatorViews.append(indicatorView)
            
            indicatorView.snp.makeConstraints { make in
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    
    func setCurrentPage(index: Int) {
        guard index >= 0 && index < numberOfPages else {
            return
        }
//        indicatorViews[currentIndex].backgroundColor = MyColors.secondary.color
        indicatorViews[index].backgroundColor = MyColors.tint.color
        currentIndex = index
    }
    
    func getCurrentPage() -> Int {
        return currentIndex
    }
}

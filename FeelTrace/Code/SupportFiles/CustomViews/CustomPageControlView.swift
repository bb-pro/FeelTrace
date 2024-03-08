//
//  CustomPageControlView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import UIKit

final class CustomPageControlView: UIView {
    
    private let height: CGFloat = 4
    private let indicatorSpacing: Int = 8
    private var indicatorViews = [UIView]()
    private var currentIndex = 0
    
    init(numberOfIndicators: Int, currentIndex: Int, progressColor: UIColor, width: CGFloat = 40, gap: CGFloat = 4) {
        super.init(frame: .zero)
        self.currentIndex = currentIndex
        setUpViews(numberOfIndicators: numberOfIndicators, progressColor: progressColor, width: width, gap: gap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(numberOfIndicators: Int, progressColor: UIColor, width: CGFloat = 40, gap: CGFloat = 4) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = gap
        addSubview(stackView)
        
        for index in 0..<numberOfIndicators {
            let indicatorView = UIView()
            indicatorView.backgroundColor = index <= currentIndex ? progressColor : UIColor.gray
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

    func setCurrentIndex(index: Int, progressColor: UIColor) {
//        guard index >= 0 && index < indicatorViews.count else {
//            return
//        }
        for i in 0..<indicatorViews.count {
            indicatorViews[i].backgroundColor = i <= index ? progressColor : UIColor.gray
        }
        currentIndex = index
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex
    }
}

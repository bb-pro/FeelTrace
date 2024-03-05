//
//  CustomButtonView.swift
//  EPayments
//
//  Created by .
//

import UIKit

struct ButtonDM {
    
    let icon: String
    let title: String
    let textColor: UIColor
    let backColor: UIColor
    let left: CGFloat?
    let right: CGFloat?
    
    init(icon: String, title: String, textColor: UIColor, backColor: UIColor, left: CGFloat? = 0, right: CGFloat? = 0) {
        self.icon = icon
        self.title = title
        self.textColor = textColor
        self.backColor = backColor
        self.left = left
        self.right = right
    }
}

protocol CustomButtonViewDelegate: AnyObject {
    func secondButtonActionbutton()
}

final class CustomButtonView: UIView {
    
    private var isVisible: Bool = false
    
    let containerview: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 20)
        label.textColor = MyColors.white.color
        label.textAlignment = .center
        return label
    }()
    lazy var actionButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    var delegate: CustomButtonViewDelegate?
    
    // MARK: - Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstrains()
    }
    
    private func setupView() {
        addSubview(containerview)
        containerview.addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    private func setupConstrains() {
        containerview.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(16)
            make.bottom.right.equalTo(-16)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(containerview.snp.top)
            make.left.equalTo(containerview.snp.left)
            make.right.equalTo(containerview.snp.right)
            make.bottom.equalTo(containerview.snp.bottom)
        }
    }
    
    func btnUpdate(item: ButtonDM) {
        containerview.backgroundColor =  item.backColor
        titleLabel.textColor = item.textColor
        titleLabel.text = item.title
        containerview.snp.makeConstraints { make in
            make.left.equalTo(item.left ?? 0)
            make.right.equalTo(item.right ?? 0)
        }
    }
    
}

// MARK: - Add Target
extension CustomButtonView {
   
    @objc fileprivate func actionButtonTapped() {
        delegate?.secondButtonActionbutton()
    }
    func actionButton(target: Any, action: Selector) {
        actionButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
}

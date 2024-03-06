//
//  SplashView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 4/3/2024.
//

import UIKit

class SplashView: UIView {
    internal lazy var progressViewWidthConstraint = progressView.widthAnchor.constraint(equalToConstant: 0)


    //MARK: - Элементы
    
    private lazy var mainLogoImage: UIImageView = {
        let image = UIImageView()
        image.image = .mainLogo
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    private(set) lazy var loadView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = MyColors.secondaryText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var progressView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = MyColors.tint.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Инициализация

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Функции
    
    private func setUpViews() {
        self.backgroundColor = MyColors.white.color
        addSubview(mainLogoImage)
        addSubview(loadView)
        loadView.addSubview(progressView)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()

        constraints += [
            mainLogoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            mainLogoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLogoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            mainLogoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100)
        ]
        
        constraints += [
            loadView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120),
            loadView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            loadView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            loadView.heightAnchor.constraint(equalToConstant: 6)
        ]
        
        constraints += [
            progressView.topAnchor.constraint(equalTo: loadView.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: loadView.leadingAnchor),
            progressView.bottomAnchor.constraint(equalTo: loadView.bottomAnchor),
            progressViewWidthConstraint,
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}


//
//  NoteCell.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class NoteCell: UITableViewCell {
    
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
        lbl.font = .customSFFont(.regular, size: 12)
        lbl.textColor = MyColors.secondaryText.color
        lbl.text = "22.01.2024"
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
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, separatorView])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundContentView.addSubview(mainStack)
        addSubview(backgroundContentView)
    }
    
    func configureUI(with note: WorkoutNote) {
        titleLabel.text = note.noteTitle
        dateLabel.text = note.date?.toString()
    }
    
    func setUpConstraints() {
        mainStack.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        backgroundContentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

//
//  NoteInfoView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class NoteInfoView: UIView {
    // MARK: - Properties
    private lazy var topImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = .grabber
        return imgView
    }()
    
    private(set) lazy var saveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private(set) lazy var starBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private(set) lazy var deleteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.tintColor = .red
        return btn
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
        lbl.font = .customSFFont(.regular, size: 17)
        lbl.textColor = MyColors.secondaryText.color
        lbl.text = "22.01.2024"
        return lbl
    }()
    
    private lazy var noteLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .customSFFont(.regular, size: 22)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    func configure(with note: WorkoutNote) {
        noteLabel.text = note.note
        dateLabel.text = note.date?.toString()
        titleLabel.text = note.noteTitle
        starBtn.tintColor = note.isFavorite ? MyColors.tint.color : MyColors.black.color
    }
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
        addSubview(topImgView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(saveBtn)
        addSubview(starBtn)
        addSubview(deleteBtn)
        addSubview(noteLabel)
    }
    
    private func setUpConstraints() {
        topImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        starBtn.snp.makeConstraints { make in
            make.right.equalTo(saveBtn.snp.left).offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(deleteBtn.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
}

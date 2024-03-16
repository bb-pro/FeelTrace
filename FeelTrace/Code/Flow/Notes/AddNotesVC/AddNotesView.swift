//
//  AddNotesView.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//

import UIKit

final class AddNotesView: UIView {
    
    // MARK: - Properties
    private lazy var topImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = .grabber
        return imgView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add note"
        label.textColor = MyColors.black.color
        label.font = .customSFFont(.regular, size: 15)
        return label
    }()
    
    private(set) lazy var saveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = MyColors.black.color
        return btn
    }()
    
    private(set) lazy var titleTF: CustomTextFieldView = {
        let titleTF = CustomTextFieldView()
        titleTF.field.placeholder = "Title"
        return titleTF
    }()

    private(set) lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.cornerRadius = 30
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = MyColors.secondaryText.color.cgColor
        return datePicker
    }()
    
    private(set) lazy var noteTextView: UITextView = {
        let noteTF = UITextView()
        noteTF.font = .customSFFont(.regular, size: 17)
        noteTF.textContainerInset = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
        noteTF.layer.borderWidth = 1
        noteTF.layer.cornerRadius = 30
        noteTF.layer.borderColor = MyColors.secondaryText.color.cgColor
        noteTF.isScrollEnabled = false
        noteTF.delegate = self
        noteTF.text = "Note"
        noteTF.textColor = MyColors.secondaryText.color
        return noteTF
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTF, datePicker, noteTextView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
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
    
    private func setUpViews() {
        addSubview(topImgView)
        addSubview(titleLabel)
        addSubview(saveBtn)
        addSubview(mainStackView)
    }
    
    private func setUpConstraints() {
        
        topImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topImgView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(30)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

extension AddNotesView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Note" {
            textView.text = ""
            textView.textColor = MyColors.black.color
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Note"
            textView.textColor = MyColors.secondaryText.color
        }
    }
}

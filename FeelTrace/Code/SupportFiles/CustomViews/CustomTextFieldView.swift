//
//  CustomTextFieldView.swift
//  EPayments
//
//  Created by Bektemur Mamashayev on 23/10/2023.
//


import UIKit
import SnapKit

class CustomTextFieldView: UIView {
    
    let field = UITextField()
    
    init(title: String? = nil,
         placeholder: String? = nil,
         fieldCornerRadius: CGFloat = 0) {
        
        super.init(frame: .zero)
        addSubview(field)
        style()
        layout()
        self.field.keyboardType = .default
        self.field.placeholder = placeholder
        self.field.leftViewMode = .always
        self.field.rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
        layout()
    }
    
    private func style() {
        field.delegate = self
        
        self.layer.cornerRadius = 30
        self.layer.borderColor = MyColors.secondaryText.color.cgColor
        self.layer.borderWidth = 1
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        field.keyboardType = .decimalPad
        field.autocorrectionType = .no
        field.delegate = self
        field.inputAccessoryView = inputAccessoryView
        field.textContentType = .none
        
    }
    
    private func layout() {
        field.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
    }
}

extension CustomTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Change border color to black when editing begins
        self.layer.borderColor = MyColors.black.color.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Change border color to secondary color when editing ends
        self.layer.borderColor = MyColors.secondaryText.color.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = string.replacingOccurrences(of: ",", with: ".")
        
        guard let currentText = textField.text else { return true }
        
        let combinedText = (currentText as NSString).replacingCharacters(in: range, with: newText)
        
        return combinedText.count <= 10
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        self.layer.borderColor = MyColors.black.color.cgColor
    }
}

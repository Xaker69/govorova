//
//  RegistrationView.swift
//  PP
//
//  Created by Максим Храбрый on 10.03.2021.
//

import UIKit
import SnapKit
class RegistrationView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ты кто?"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let loginTextField: AuthTextField = {
        let view = AuthTextField()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        view.keyboardAppearance = .dark
        view.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [.foregroundColor: UIColor.black]
        )
        
        
        return view
    }()
    
    let passworsTextField: AuthTextField = {
        let view = AuthTextField()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        view.keyboardAppearance = .dark
        view.isSecureTextEntry = true
        view.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [.foregroundColor: UIColor.black]
        )
        
        return view
    }()
    
    let enterButton: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = UIColor(hex: 0x878dde)
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    let registrationButton: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("Нет аккаунта?", for: .normal)
        button.setTitleColor(UIColor(hex: 0x5157a6), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        addSubview(titleLabel)
        addSubview(loginTextField)
        addSubview(passworsTextField)
        addSubview(enterButton)
        addSubview(registrationButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        loginTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(44)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        passworsTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(44)
            make.top.equalTo(loginTextField.snp.bottom).offset(12)
        }
        enterButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(44)
            make.top.equalTo(passworsTextField.snp.bottom).offset(12)
        }
        registrationButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
            make.top.equalTo(enterButton.snp.bottom).offset(12)
        }
    }
    
}

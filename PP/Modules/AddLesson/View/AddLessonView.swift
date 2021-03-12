//
//  AddLessonView.swift
//  PP
//
//  Created by Максим Храбрый on 11.03.2021.
//

import UIKit

class AddLessonView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Добавить Занятие"
        
        return label
    }()
    
    let typeLessonTextField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Тип Занятия"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let timeStartTextField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Время начала"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let timeEndTextField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Время конца"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let dayOfWeekTextField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "День недели"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let groupNumberTextField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Номер группы"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.keyboardType = .numberPad
        
        return view
    }()
    
    let nameTextField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Название предмета"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let codeField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Код дисциплины"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.keyboardType = .numberPad
        
        return view
    }()
    
    let audienceNumberField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Номер аудитории"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.keyboardType = .numberPad
        
        return view
    }()
    
    let audienceTypeField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Тип аудитории"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let audienceRoominessField: AuthTextField = {
        let view = AuthTextField()
        view.layer.cornerRadius = 8
        view.placeholder = "Вместительность"
        view.textColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.keyboardType = .numberPad
        
        return view
    }()
    
    let saveButton: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = UIColor(hex: 0x5698e3)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: 0xc1daf7)
        
        addSubview(titleLabel)
        addSubview(typeLessonTextField)
        addSubview(timeStartTextField)
        addSubview(timeEndTextField)
        addSubview(dayOfWeekTextField)
        addSubview(groupNumberTextField)
        addSubview(nameTextField)
        addSubview(codeField)
        addSubview(audienceNumberField)
        addSubview(audienceTypeField)
        addSubview(audienceRoominessField)
        addSubview(saveButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview()
        }
        typeLessonTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        timeStartTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(typeLessonTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        timeEndTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(timeStartTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        dayOfWeekTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(timeEndTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        groupNumberTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(dayOfWeekTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        nameTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(groupNumberTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        codeField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        audienceNumberField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(codeField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        audienceTypeField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(audienceNumberField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        audienceRoominessField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(audienceTypeField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(44)
            make.top.equalTo(audienceRoominessField.snp.bottom).offset(12)
        }
    }
}


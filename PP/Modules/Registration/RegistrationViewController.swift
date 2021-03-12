//
//  RegistrationViewController.swift
//  PP
//
//  Created by Максим Храбрый on 10.03.2021.
//

import UIKit
import RealmSwift

class RegistrationViewController: UIViewController {
    
    var mainView: RegistrationView {
        return view as! RegistrationView
    }
    
    private var isRegistration: Bool = false
    
    override func loadView() {
        let view = RegistrationView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.loginTextField.delegate = self
        mainView.passworsTextField.delegate = self
        
        mainView.loginTextField.addTarget(self, action: #selector(textFieldTapped), for: .editingDidBegin)
        mainView.passworsTextField.addTarget(self, action: #selector(textFieldTapped), for: .editingDidBegin)
        mainView.registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        mainView.enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        mainView.addGestureRecognizer(gesture)
        
        
//        let realm = try! Realm()
        
//        let audiense = AudienceModel()
//        audiense.roominess = 22
//        audiense.roomNumber = 202
//        audiense.type = "Практика"
        
        // 203 - экономика отрасли
        // 209 - Психология общения
        // 305 - Иностранный язык
        
        //10 00
//        let lesson = LessonModel()
//        lesson.audience = audiense
//        lesson.code = 305
//        lesson.type = "Практика"
//        lesson.timeStart = Date(timeIntervalSince1970: 1615197600)
//        lesson.timeEnd = Date(timeIntervalSince1970: 1615203000)
//        lesson.dayOfWeek = "Ср"
//        lesson.groupNumber = 2335
//        lesson.name = "Иностранный язык"
//
//        //11 40
//        let lesson1 = LessonModel()
//        lesson.audience = audiense
//        lesson.code = 230509
//        lesson.type = "Лекция"
//        lesson.timeStart = Date(timeIntervalSince1970: 1615203600)
//        lesson.timeEnd = Date(timeIntervalSince1970: 1615209000)
//        lesson.dayOfWeek = "Ср"
//        lesson.groupNumber = 2335
//        lesson.name = "Иностранный язык"
//
//        // 13 30
//        let lesson2 = LessonModel()
//        lesson.audience = audiense
//        lesson.code = 305
//        lesson.type = "Практика"
//        lesson.timeStart = Date(timeIntervalSince1970: 1615210200)
//        lesson.timeEnd = Date(timeIntervalSince1970: 1615216200)
//        lesson.dayOfWeek = "Ср"
//        lesson.groupNumber = 2331
//        lesson.name = "Иностранный язык"
//
//        // 15 20
//        let lesson3 = LessonModel()
//        lesson.audience = audiense
//        lesson.code = 305
//        lesson.type = "Лекция"
//        lesson.timeStart = Date(timeIntervalSince1970: 1615216800)
//        lesson.timeEnd = Date(timeIntervalSince1970: 1615222200)
//        lesson.dayOfWeek = "Ср"
//        lesson.groupNumber = 2331
//        lesson.name = "Иностранный язык"
//
//        //17 00
//        let lesson4 = LessonModel()
//        lesson.audience = audiense
//        lesson.code = 209
//        lesson.type = "Лекция"
//        lesson.timeStart = Date(timeIntervalSince1970: 1615222800)
//        lesson.timeEnd = Date(timeIntervalSince1970: 1615228200)
//        lesson.dayOfWeek = "Вт"
//        lesson.groupNumber = 2335
//        lesson.name = "Экономика отрасли"
//
//        let lecture = LectureModel()
//        lecture.name = "Алла Дмитриевна"
//        lecture.lessons.append(objectsIn: [lesson, lesson1, lesson2, lesson3])
        
            
        
//        try! realm.write {
//            realm.add(lecture)
//        }
    }
    
    @objc private func textFieldTapped(_ sender: UITextField) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        }
    }
    
    @objc private func viewTapped() {
        mainView.loginTextField.resignFirstResponder()
        mainView.passworsTextField.resignFirstResponder()
    }
    
    @objc private func registrationButtonTapped() {
        isRegistration = !isRegistration
        changeTitles()
    }
    
    @objc private func enterButtonTapped() {
        let realm = try! Realm()
        if isRegistration {
            let user = User()
            user.name = mainView.loginTextField.text ?? ""
            user.password = mainView.passworsTextField.text ?? ""
            try! realm.write({
                realm.add(user)
            })
            
            let vc = ContainerViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        } else {
            let hasLogin = realm.objects(User.self).contains { user -> Bool in
                user.name == mainView.loginTextField.text
            }
            let hasPassword = realm.objects(User.self).contains { user -> Bool in
                user.password == mainView.passworsTextField.text
            }
            if !hasLogin {
                mainView.loginTextField.shakeAnimateion()
            } else if !hasPassword {
                mainView.passworsTextField.shakeAnimateion()
            } else {
                let vc = ContainerViewController()
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        }
    }
    
    private func changeTitles() {
        UIView.transition(with: mainView.titleLabel, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.mainView.titleLabel.text = self.isRegistration ? "Зарегестрируемся?" : "Ты кто?"
            self.mainView.registrationButton.isEnabled = false
        }) { _ in
            self.mainView.registrationButton.isEnabled = true
        }
        
        UIView.transition(with: mainView.registrationButton, duration: 0.3, options: .transitionCrossDissolve) {
            self.mainView.registrationButton.setTitle(self.isRegistration ? "Есть аккаунт?" : "Нет аккаунта?", for: .normal)
        }
        
        UIView.transition(with: mainView.enterButton, duration: 0.3, options: .transitionCrossDissolve) {
            self.mainView.enterButton.setTitle(self.isRegistration ? "Зарегестрироваться" : "Войти", for: .normal)
        }

        clearTextFields()
    }
    
    private func clearTextFields() {
        mainView.loginTextField.text = nil
        mainView.passworsTextField.text = nil
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            UIView.animate(withDuration: 0.3) {
                textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            }
        }
    }
}

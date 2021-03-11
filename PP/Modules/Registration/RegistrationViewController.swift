//
//  RegistrationViewController.swift
//  PP
//
//  Created by Максим Храбрый on 10.03.2021.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {
    
    var mainView: RegistrationView {
        return view as! RegistrationView
    }
    
    //Самое приложение
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    //Контейнер
    var container: NSPersistentContainer!
    //Контекст
    var context: NSManagedObjectContext!
    
    var users = [User]()
    
    private var isRegistration: Bool = false
    
    override func loadView() {
        let view = RegistrationView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = appDelegate.persistentContainer
        context = container.viewContext
        fetchData()
        
        mainView.loginTextField.delegate = self
        mainView.passworsTextField.delegate = self
        
        mainView.loginTextField.addTarget(self, action: #selector(textFieldTapped), for: .editingDidBegin)
        mainView.passworsTextField.addTarget(self, action: #selector(textFieldTapped), for: .editingDidBegin)
        mainView.registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        mainView.enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        mainView.addGestureRecognizer(gesture)
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
        if isRegistration {
            let user = User(context: context)
            user.name = mainView.loginTextField.text
            user.password = mainView.passworsTextField.text
            appDelegate.saveContext()
            fetchData()
        } else {
            if !users.map({ $0.name }).contains(mainView.loginTextField.text) {
                mainView.loginTextField.shakeAnimateion()
            } else if !users.map({ $0.password }).contains(mainView.passworsTextField.text) {
                mainView.passworsTextField.shakeAnimateion()
            } else {
                print("success")
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
    
    private func fetchData() {
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        //Нужно явное указание типа, чтобы разбить неопределённость между методом класса и тем, что достался от objc

        do {
            users = try context.fetch(request)
        } catch {
            print(error)
        }
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

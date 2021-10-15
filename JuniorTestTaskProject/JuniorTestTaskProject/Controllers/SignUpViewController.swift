//
//  SignUpViewController.swift
//  JuniorTestTaskProject
//
//  Created by Pavel Olegovich on 12.10.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Имя"
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Фамилия"
        return textField
    }()
    
    private let secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let birthdayValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Телефон"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    private let birthdayDatePicker = UIDatePicker()
    
    let validSymbol = "\u{2713}"
    
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
//    let phoneValidType: String.ValidTypes = .phone
    let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstraints()
        setupBirthdayDatePicker()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    private func setupViews() {
        title = "SignUp"
        
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           secondNameTextField,
                                                           secondNameValidLabel,
                                                           birthdayDatePicker,
                                                           birthdayValidLabel,
                                                           phoneNumberTextField,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(registrationLabel)
        backgroundView.addSubview(signUpButton)
        
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupBirthdayDatePicker() {
        birthdayDatePicker.datePickerMode = .date
        birthdayDatePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        birthdayDatePicker.layer.borderColor = #colorLiteral(red: 0.9401981235, green: 0.94532758, blue: 0.945061028, alpha: 1)
        birthdayDatePicker.layer.borderWidth = 1
        birthdayDatePicker.clipsToBounds = true
        birthdayDatePicker.layer.cornerRadius = 6
        birthdayDatePicker.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @objc private func signUpButtonTapped() {
        let firstNameText = firstNameTextField.text ?? ""
        let secondNameText = secondNameTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let phoneText = phoneNumberTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType)
            && secondNameText.isValid(validType: nameValidType)
            && emailText.isValid(validType: emailValidType)
            && passwordText.isValid(validType: passwordValidType)
            && phoneText.count == 18
            && ageIsValid() == true {
            DataBase.shared.saveUser(firstName: firstNameText,
                                     secondName: secondNameText,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText,
                                     age: birthdayDatePicker.date)
            show(title: "", message: "Вы успешно зарегистрировались!", action: true)
        } else {
            show(title: "Ошибка регистрации", message: "Повторите попытку.", action: false)
        }
    }
    
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
        } else {
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
    }
    
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex

        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            phoneValidLabel.text = validSymbol
            phoneValidLabel.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
        } else {
            phoneValidLabel.text = "Неверный формат..."
            phoneValidLabel.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        
        return result
    }
    
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = birthdayDatePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameValidLabel,
                                              validType: nameValidType,
                                              validMessage: validSymbol,
                                              wrongMessage: "а-я, А-Я, мин. 1 символ",
                                              string: string,
                                              range: range)
            
        case secondNameTextField: setTextField(textField: secondNameTextField,
                                              label: secondNameValidLabel,
                                              validType: nameValidType,
                                              validMessage: validSymbol,
                                              wrongMessage: "а-я, А-Я, мин. 1 символ",
                                              string: string,
                                              range: range)
            
        case emailTextField: setTextField(textField: emailTextField,
                                              label: emailValidLabel,
                                              validType: emailValidType,
                                              validMessage: validSymbol,
                                              wrongMessage: "Неверный формат...",
                                              string: string,
                                              range: range)
            
//        case phoneNumberTextField: setTextField(textField: phoneNumberTextField,
//                                              label: phoneValidLabel,
//                                              validType: phoneValidType,
//                                              validMessage: validSymbol,
//                                              wrongMessage: "Неверный формат...",
//                                              string: string,
//                                              range: range)
            
        case phoneNumberTextField: phoneNumberTextField.text = setPhoneNumberMask(textField: phoneNumberTextField,
                                                                                  mask: "+X (XXX) XXX-XX-XX",
                                                                                  string: string,
                                                                                  range: range)
            
        case passwordTextField: setTextField(textField: passwordTextField,
                                              label: passwordValidLabel,
                                              validType: passwordValidType,
                                              validMessage: validSymbol,
                                              wrongMessage: "По 1 сим.: a-z, A-Z, 0-9 и мин. длинна: 6 сим.",
                                              string: string,
                                              range: range)
        default:
            break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Keyboard Show/Hide
extension SignUpViewController {
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}

extension SignUpViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            registrationLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            registrationLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

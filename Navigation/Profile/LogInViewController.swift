//
//  LogInViewController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 16.05.2022.
//
import UIKit

class LogInViewController: UIViewController {
    
    private let nc = NotificationCenter.default
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var logInView : UIView = {
        let logInView = UIView()
        return logInView
    }()
    
    lazy var logoImageView : UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        return logoImageView
    }()
    
    lazy var logInStackView : UIStackView = {
        let logInStackView = UIStackView()
        logInStackView.axis = .vertical
        logInStackView.layer.borderColor = UIColor.lightGray.cgColor
        logInStackView.layer.borderWidth = 0.5
        logInStackView.layer.cornerRadius = 10
        logInStackView.backgroundColor = .systemGray6
        logInStackView.tintColor = .lightGray
        logInStackView.layer.masksToBounds = true
        return logInStackView
    }()
    
    lazy var loginTextField : UITextField = {
        let loginTextField = UITextField()
        loginTextField.placeholder = "Email или номер телефона"
        loginTextField.textColor = .black
        loginTextField.font = .systemFont(ofSize: 16, weight: .regular)
        loginTextField.autocapitalizationType = .none
        loginTextField.layer.borderWidth = 0.25
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.autoresizesSubviews = true
        loginTextField.delegate = self
        return loginTextField
    }()
    
    lazy var passwordTextField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 0.25
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.delegate = self
        return passwordTextField
    }()
    
    lazy var logInButton : UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Войти", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        let image = UIImage(named: "blue_pixel")
        let normalstateImage = image?.image(alpha: 1)
        let anotherstateImage = image?.image(alpha: 0.8)
        logInButton.setBackgroundImage(normalstateImage, for: .normal)
        logInButton.setBackgroundImage(anotherstateImage, for: .selected)
        logInButton.setBackgroundImage(anotherstateImage, for: .highlighted)
        logInButton.setBackgroundImage(anotherstateImage, for: .disabled)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.addTarget(self, action: #selector(inButton), for: .touchUpInside)
        return logInButton
    }()
    
    @objc func inButton() {
        let viewController = ProfileViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(logInView)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        
        logInView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logInView.addSubview(logInStackView)
        logInStackView.translatesAutoresizingMaskIntoConstraints = false
        
        logInStackView.insertArrangedSubview(loginTextField, at: 0)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        logInStackView.insertArrangedSubview(passwordTextField, at: 1)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        logInView.addSubview(logInButton)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logInView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            logInView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            logInView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            logInView.widthAnchor.constraint(equalTo:  scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: logInView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: logInView.safeAreaLayoutGuide.centerXAnchor),
            
            logInStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            logInStackView.heightAnchor.constraint(equalToConstant: 100),
            logInStackView.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            logInStackView.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            
            loginTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            
            logInButton.topAnchor.constraint(equalTo: logInStackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: logInView.bottomAnchor, constant: -16)
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}

extension LogInViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
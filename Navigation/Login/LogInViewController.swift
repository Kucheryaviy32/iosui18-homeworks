//
//  LogInViewController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 16.05.2022.
//
import UIKit

class LogInViewController: UIViewController {
    
    private let nc = NotificationCenter.default
    
    var delegate: LoginViewControllerDelegate?
    var callback: (_ authenticationData: (userService: UserService, name: String)) -> Void
    
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
        loginTextField.placeholder = LocalizedService.getText(key: .insertLogIn)
                #if DEBUG
        loginTextField.text = "siv@mail.ru"
                #else
                #endif
        loginTextField.textColor = .black
        loginTextField.font = .systemFont(ofSize: 16, weight: .regular)
        loginTextField.autocapitalizationType = .none
        loginTextField.layer.borderWidth = 0.25
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.autoresizesSubviews = true
        loginTextField.delegate = self
        loginTextField.addTarget(self, action: #selector(editingEnded), for: .editingChanged)
        return loginTextField
    }()
    
    
    lazy var passwordTextField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = LocalizedService.getText(key: .insertPassword)
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 0.25
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(editingEnded), for: .editingChanged)
        return passwordTextField
    }()
    
    lazy var logInButton : UIButton = {
        let logIn = UIButton()
        logIn.translatesAutoresizingMaskIntoConstraints = false
        logIn.layer.cornerRadius = 10
        logIn.clipsToBounds = true
        logIn.setTitle(LocalizedService.getText(key: .logIn), for: .normal)
        //        logIn.titleLabel?.textColor = .white
        logIn.layer.shadowColor = UIColor.black.cgColor
        logIn.layer.shadowOffset = CGSize(width: 4, height: 4)
        logIn.layer.shadowOpacity = 0.7
        logIn.layer.shadowRadius = 4
        logIn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        logIn.isEnabled = false
        let image = UIImage(named: "blue_pixel")
        let normalstateImage = image?.image(alpha: 1)
        let anotherstateImage = image?.image(alpha: 0.8)
        logIn.setBackgroundImage(normalstateImage, for: .normal)
        logIn.setBackgroundImage(anotherstateImage, for: .selected)
        logIn.setBackgroundImage(anotherstateImage, for: .highlighted)
        logIn.setBackgroundImage(anotherstateImage, for: .disabled)
        logIn.layer.cornerRadius = 10
        logIn.layer.masksToBounds = true
        return logIn
    }()
    
    lazy var regIn: UIButton = {
        let regIn = UIButton()
        regIn.translatesAutoresizingMaskIntoConstraints = false
        regIn.layer.cornerRadius = 10
        regIn.clipsToBounds = true
        regIn.setTitle(LocalizedService.getText(key: .regIn), for: .normal)
        //        regIn.titleLabel?.textColor = .white
        regIn.layer.shadowColor = UIColor.black.cgColor
        regIn.layer.shadowOffset = CGSize(width: 4, height: 4)
        regIn.layer.shadowOpacity = 0.7
        regIn.layer.shadowRadius = 4
        regIn.addTarget(self, action: #selector(registerIn), for: .touchUpInside)
        regIn.isEnabled = false
        
        let image = UIImage(named: "blue_pixel")
        let normalstateImage = image?.image(alpha: 1)
        let anotherstateImage = image?.image(alpha: 0.8)
        regIn.setBackgroundImage(normalstateImage, for: .normal)
        regIn.setBackgroundImage(anotherstateImage, for: .selected)
        regIn.setBackgroundImage(anotherstateImage, for: .highlighted)
        regIn.setBackgroundImage(anotherstateImage, for: .disabled)
        regIn.layer.cornerRadius = 10
        regIn.layer.masksToBounds = true
        return regIn
    }()
    
    //    let inButton = {(vc: LogInViewController) in
    //        if let loginInspector = vc.delegate {
    //            if loginInspector.checkPassword(login: vc.loginTextField.text ?? "", password: vc.passwordTextField.text ?? "") {
    //                vc.logined()
    //            }
    //            else {
    //                let alertController = UIAlertController(title: "Ошибка авторизации",
    //                                                        message: "Неверный логин или пароль",
    //                                                        preferredStyle: .alert)
    //                let action = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
    //                alertController.addAction(action)
    //                vc.present(alertController, animated: true, completion: nil)
    //                vc.passwordTextField.text = nil
    //            }
    //        }
    //    }
    
    var queue: DispatchQueue? = nil
    
    init(callback: @escaping (_ authenticationData: (userService: UserService, name: String)) -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        logInView.addSubview(regIn)
        regIn.translatesAutoresizingMaskIntoConstraints = false
        
        
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
            logInButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 -  16),
            //            logInButton.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: logInView.bottomAnchor, constant: -16),
            
            regIn.topAnchor.constraint(equalTo: logInStackView.bottomAnchor, constant: 16),
            regIn.leadingAnchor.constraint(equalTo: logInButton.trailingAnchor, constant: 16),
            regIn.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            regIn.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        
#if release
        loginTextField.text = ""
#elseif DEBUG
        loginTextField.text = "siv@mail.ru"
#endif
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
    
    @objc func editingEnded() {
        regIn.isEnabled = self.loginTextField.text != "" && self.passwordTextField.text != ""
        logInButton.isEnabled = regIn.isEnabled
    }
    
    func logined() {
        let userService = CurrentUserService(name: loginTextField.text ?? "", avatar: "ProfileImage", status: "Когда уже новый сезон?")
        callback((userService: userService, name: loginTextField.text ?? ""))
    }
    
    @objc func signIn() {
        if let delegate = delegate {
            let userName = self.loginTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            
            DispatchQueue.global().async {
                delegate.signIn(login: userName, password: password) { (result, message) in
                    switch result {
                    case .success(true) :
                        DispatchQueue.main.async {
                            self.logined()
                        }
                    case .success(false):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    case .failure(.unauthorized):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    default:
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: "Критическая ошибка авторизации, попробуйте перезапустить приложение", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true) { fatalError() }
                            
                        }
                    }
                }
            }
        }
    }
    
    @objc func registerIn() {
        
        if let delegate = delegate {
            let userName = self.loginTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            
            DispatchQueue.global().async {
                delegate.registerIn(login: userName, password: password) { result, message in
                    switch result {
                    case .success(true) :
                        DispatchQueue.main.async {
                            self.logined()
                        }
                    case .success(false):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    case .failure(.unauthorized):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    default:
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: "Критическая ошибка авторизации, попробуйте перезапустить приложение", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true) { fatalError() }
                            
                        }
                    }
                }
            }
        }
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

//
//  FeedViewController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 14.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
        
    let postStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    lazy var firstButton: CustomButton = {
        let button = CustomButton(vc: self,
                                  text: "Пост 1",
                                  backgroundColor: .blue,
                                  backgroundImage: nil,
                                  tag: 0,
                                  shadow: true) {
            (vc: UIViewController, sender: CustomButton) in
            self.showPost(sender: sender)
        }
        
        button.layer.cornerRadius = 4
        return button
    }()
    
    lazy var secondButton: CustomButton = {
        let button =  CustomButton(vc: self,
                                   text: "Пост 2",
                                   backgroundColor: .blue,
                                   backgroundImage: nil,
                                   tag: 1,
                                   shadow: true) {
            (vc: UIViewController, sender: CustomButton) in
            self.showPost(sender: sender)
        }
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    lazy var answerTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.placeholder = "Введите Green =)"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.textAlignment = .natural
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var answerButton: CustomButton = {
        let button = CustomButton(vc: self,
                                  text: "Проверить текст",
                                  backgroundColor: .blue,
                                  backgroundImage: nil,
                                  tag: 0,
                                  shadow: true) {
            (vc:UIViewController, sender: CustomButton) in
            if self.model.check(word: self.answerTextField.text!) {sender.notification = {self.indicationLabel.textColor = .green
                self.indicationLabel.text = "Верно"
            }}
            else {
                sender.notification = {self.indicationLabel.textColor = .red
                    self.indicationLabel.text = "Про Green для кого написано?"
                    
                }
            }
        }
        
        button.layer.cornerRadius = 4
        button.addTextField(textField: answerTextField)
        return button
    }()
    
    lazy var indicationLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var coordinator: FeedCoordinator
    var model: FeedModel
    
    init(coordinator: FeedCoordinator, model: FeedModel) {
        self.model = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новости"
        self.view.backgroundColor = .white
        view.addSubview(postStackView)
        postStackView.insertArrangedSubview(firstButton, at: 0)
        postStackView.insertArrangedSubview(secondButton, at: 1)
        postStackView.insertArrangedSubview(answerTextField, at: 2)
        postStackView.insertArrangedSubview(answerButton, at: 3)
        postStackView.insertArrangedSubview(indicationLabel, at: 4)
        postStackView.autoresizesSubviews = true
        postStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            postStackView.widthAnchor.constraint(equalToConstant: 200),
            postStackView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func showPost(sender: CustomButton) {
        model.getPost(sender: sender)
}
}

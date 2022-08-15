//
//  FeedViewController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 14.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    let postStackView : UIStackView = {
        let postStackView = UIStackView()
        postStackView.spacing = 10
        
        postStackView.axis = .vertical
        return postStackView
    }()
    
    let firstButton : UIButton = {
        let firstButton = UIButton()
            firstButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
    firstButton.backgroundColor = .blue
    firstButton.setTitle("Пост 1", for: .normal)
        
    return firstButton
    }()
      
    let secondButton : UIButton = {
        let secondButton = UIButton()
        secondButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        secondButton.backgroundColor = .blue
        secondButton.setTitle("Пост 2", for: .normal)
      
    return secondButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новости"
        self.view.backgroundColor = .white
        view.addSubview(postStackView)

        postStackView.insertArrangedSubview(firstButton, at: 0)
        postStackView.insertArrangedSubview(secondButton, at: 1)
        postStackView.autoresizesSubviews = true

        postStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            postStackView.widthAnchor.constraint(equalToConstant: 200),
            postStackView.heightAnchor.constraint(equalToConstant: 100),
            firstButton.heightAnchor.constraint(equalTo: secondButton.heightAnchor)
        ])
    }
    
    @objc func postButtonAction() {
       
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    
    }

}

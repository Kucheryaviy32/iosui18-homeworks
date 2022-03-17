//
//  FeedViewController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 14.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let postButton = UIButton(frame: CGRect(x: 160, y: 100, width: 100, height: 50))
        postButton.backgroundColor = .red
        postButton.setTitle("Пост", for: .normal)
        postButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        self.view.addSubview(postButton)
        
    }

    
    @objc func postButtonAction() {
       
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    
    }

}

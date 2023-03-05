import UIKit

class InformationViewController: UIViewController {
    
    lazy var alertButton: CustomButton = {
        var button = CustomButton(vc: self,
                                  text: "Внимание",
                                  backgroundColor: .gray,
                                  backgroundImage: nil,
                                  tag: nil,
                                  shadow: false,
                                  tapAction: alert)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 100),
            alertButton.widthAnchor.constraint(equalToConstant: 200),
            alertButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    let alert = {(vc: UIViewController, sender: CustomButton) in
        
        
        let alert = UIAlertController(title: "Тревожное сообщение", message: "При отправке запроса произошла ошибка", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction (title: "FirstAlertAction", style: .default) {_ in print ("First Alert Action")}
        let secondAlertAction = UIAlertAction (title: "SecondAlertAction", style: .default) {_ in print ("Second Alert Action")}
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        vc.present(alert, animated: true, completion: nil)
    }
}

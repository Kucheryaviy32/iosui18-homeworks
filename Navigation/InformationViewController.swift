import UIKit

class InformationViewController: UIViewController {

    var alertButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        
        alertButton = UIButton(frame: CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 60))
                               
        alertButton.layer.cornerRadius = 25
        alertButton.backgroundColor = .gray
        alertButton.setTitle("Внимание", for: .normal)
        
        alertButton.addTarget(self, action: #selector(alert), for: .touchUpInside)
        view.addSubview(alertButton)
        }
    
    
    @objc func alert() {
        let alert = UIAlertController(title: "Тревожное сообщение", message: "При отправке запроса произошла ошибка", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction (title: "FirstAlertAction", style: .default) {_ in print ("First Alert Action")}
        let secondAlertAction = UIAlertAction (title: "SecondAlertAction", style: .default) {_ in print ("Second Alert Action")}
    
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }

}

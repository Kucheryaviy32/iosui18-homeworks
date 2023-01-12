import UIKit

class PostViewController: UIViewController {

    var postTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        self.title = postTitle
        
        let informationBarItem: UIBarButtonItem = UIBarButtonItem(title: "Информация", style: .plain, target: self, action: #selector(openInfo))
        
        navigationItem.rightBarButtonItem = informationBarItem
        
    }
    
@objc func openInfo() {
        let informationVC = InformationViewController()
navigationController?.present(informationVC, animated: true, completion: nil)
    }
    
    
}

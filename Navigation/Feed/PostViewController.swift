import UIKit

struct Post_old {
    var title : String
    //    var image : UIImage
    //    var info : String
}

class PostViewController: UIViewController {
    
    var post : Post_old
    let coordinator: FeedCoordinator
    
    init(coordinator: FeedCoordinator, post: Post_old) {
        self.post = post
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var postTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        self.title = postTitle
        
        let informationBarItem: UIBarButtonItem = UIBarButtonItem(title: "Информация", style: .plain, target: self, action: #selector(openInfo))
        
        navigationItem.rightBarButtonItem = informationBarItem
        
    }
    
    @objc func openInfo() {
        coordinator.showInfoPost()
    }
    
    
}

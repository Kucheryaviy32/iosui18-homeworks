
import UIKit
import StorageService


class ProfileViewController: UIViewController {
    
    private lazy var profileTableView : UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return tableView
    }()
    
    let massivFeed = Post.postFeed()
    
    
    
    
    private let userService: UserService
    
    init(userService: UserService){
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        #if DEBUG
        profileTableView.backgroundColor = .systemRed
        #else
        profileTableView.backgroundColor = .white
        #endif
        
        super.viewDidLoad()
        view.addSubview(profileTableView)

        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension ProfileViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        massivFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.setup(massivFeed[indexPath.row])
        return cell

    }
}


extension ProfileViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = ProfileHeaderView()
        header.userNameLabel.text = userService.user?.name
        header.profileImageView.image = userService.user?.avatar
        header.statusLabel.text = userService.user?.status
        return header
    }
}

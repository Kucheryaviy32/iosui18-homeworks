
import UIKit
import StorageService
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private lazy var profileTableView : UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    let massivFeed = Post.postFeed()
    let userName: String
    let userService: UserService
    let coordinator: ProfileCoordinator
    
    init(coordinator: ProfileCoordinator, userService: UserService, name: String){
        self.userService = userService
        self.coordinator = coordinator
        self.userName = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEBUG
        profileTableView.backgroundColor = .systemRed
#else
        profileTableView.backgroundColor = .white
#endif
        let exitBarButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(exitToProfile))
        navigationItem.rightBarButtonItem  = exitBarButton
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire)
        profileTableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        profileTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        
        view.addSubview(profileTableView)
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showHeader() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        DispatchQueue.global().async {
            sleep(3)
            DispatchQueue.main.async {
                self.dismisHeader()
            }
        }
    }
    
    func dismisHeader() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func updatePostArray() {
        profileTableView.reloadData()
        profileTableView.refreshControl?.endRefreshing()
        showHeader()
    }
    
    @objc func exitToProfile() {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            coordinator.DissmisApp()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        section == 1 ? self.massivFeed.count : 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
            cell.setup(massivFeed[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifire, for: indexPath) as! PhotosTableViewCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
            
            if let user = userService.getUser(name: userName) {
                headerView.initUserData(user: user)
            }
            return headerView
        } else
        { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 228
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
    
}

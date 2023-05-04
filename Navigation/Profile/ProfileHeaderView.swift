import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    static let identifire = "ProfileHeaderView"
    
    lazy var profileImageView : UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "ProfileImage")
        profileImageView.layer.cornerRadius = CGFloat(50)
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()
    
    lazy var userNameLabel : UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "Пользователь не найден"
        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        userNameLabel.textColor = .black
        userNameLabel.clipsToBounds = true
        return userNameLabel
    }()
    
    lazy var statusLabel : UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = ""
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    
    lazy var statusTextField : UITextField = {
        let statusTextField = UITextField()
        statusTextField.backgroundColor = .white
        statusTextField.placeholder = LocalizedService.getText(key: .insertNewStatus)
        statusTextField.textAlignment = NSTextAlignment.center
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .gray
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        return statusTextField
    }()
    
    lazy var statusButton : UIButton = {
        let statusButton =  UIButton()
        statusButton.setTitle(LocalizedService.getText(key: .changeStatus), for: .normal)
        statusButton.backgroundColor = .blue
        statusButton.layer.cornerRadius = 4
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.addTarget(self, action: #selector(statusButtonAction), for: .touchUpInside)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        
        return statusButton
    }()
    
    var statusText : String = ""
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statusTextField)
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statusButton)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 46),
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            statusTextField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initUserData(user: User) {
        userNameLabel.text = user.name
        profileImageView.image = user.avatar
        statusLabel.text = user.status
    }
    
    @objc func statusTextChanged() {
        statusText = String(statusTextField.text!)
    }
    
    @objc func statusButtonAction() {
        statusLabel.text = statusText
        print (statusLabel.text!) //оставил соблюдение условия по выводу в консоль
        statusTextField.text = nil // очищаем поле ввода статуса, в условии задачи не было, но без этого некрасиво
    }
    
}

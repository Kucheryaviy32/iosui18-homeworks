
import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private lazy var profileImageView : UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "ProfileImage")
        profileImageView.layer.cornerRadius = CGFloat(50)
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()
    
    private lazy var userNameLabel : UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "Рик Санчез"
        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        userNameLabel.textColor = .black
        userNameLabel.clipsToBounds = true
        return userNameLabel
    }()
    
    private lazy var statusLabel : UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Морти, за мной!"
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    
    private lazy var statusTextField : UITextField = {
        let statusTextField = UITextField()
        statusTextField.backgroundColor = .white
        statusTextField.placeholder = "Введите новый статус"
        statusTextField.textAlignment = NSTextAlignment.center
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .gray
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        return statusTextField
    }()
    
    private lazy var statusButton : UIButton = {
        let statusButton =  UIButton()
        statusButton.setTitle("Поменять статус", for: .normal)
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
    
    private var statusText : String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
            
        profileImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(16)
            maker.left.equalToSuperview().inset(16)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            }
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp_trailingMargin).inset(-16)
            make.trailing.equalToSuperview().inset(-16)
            make.top.equalToSuperview().inset(27)
        }
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp_bottomMargin).inset(-46)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(16)
        }
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp_trailingMargin).inset(-16)
            make.bottom.equalTo(statusButton.snp_topMargin).inset(-34)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp_trailingMargin).inset(-16)
            make.bottom.equalTo(statusTextField.snp_topMargin).inset(-16)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


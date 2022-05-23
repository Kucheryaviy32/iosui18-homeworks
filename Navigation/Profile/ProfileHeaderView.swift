
import UIKit

class ProfileHeaderView: UIView {
    
    
    let profileImageView : UIImageView = {
        let profileImageView = UIImageView()
        let radiusImage = 128
        profileImageView.image = UIImage(named: "ProfileImage")
        profileImageView.frame.size = CGSize(width: radiusImage, height: radiusImage)
        profileImageView.layer.cornerRadius = CGFloat((radiusImage) / 2)
        profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true
        return profileImageView
    }()
    
    let userNameLabel : UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "Рик Санчез"
        userNameLabel.frame.size = CGSize(width: 200, height: 18)
        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        userNameLabel.textColor = .black
        userNameLabel.clipsToBounds = true
        return userNameLabel
    }()

    let statusLabel : UILabel = {
       let statusLabel = UILabel()
        statusLabel.frame.size = CGSize(width: 200, height: 14)
        statusLabel.text = "Морти, за мной!"
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    
    let statusTextField : UITextField = {
       let statusTextField = UITextField()
        statusTextField.frame.size = CGSize(width: 200, height: 40)
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
    
    var statusButton : UIButton = {
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
    
    @objc func statusTextChanged() {
        statusText = String(statusTextField.text!)
    }
    
    @objc func statusButtonAction() {
        statusLabel.text = statusText
        print (statusLabel.text!) //оставил соблюдение условия по выводу в консоль
        statusTextField.text = nil // очищаем поле ввода статуса, в условии задачи не было, но без этого некрасиво
    }
    
    
    
}

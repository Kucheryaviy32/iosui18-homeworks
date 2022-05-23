
import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Профиль"
        self.view.addSubview(profileHeaderView)


    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()

        profileHeaderView.backgroundColor = .systemGray5
        //выбрал не .lightGray потому что он получился очень темным
        
        profileHeaderView.frame.origin = CGPoint(x: self.view.safeAreaInsets.left, y: self.view.safeAreaInsets.top)
        profileHeaderView.frame.size = CGSize(width: view.frame.width, height: view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom)
        //для сабвью определил "безопасные" границы
        
        profileHeaderView.addSubview(profileHeaderView.profileImageView)
        profileHeaderView.addSubview(profileHeaderView.userNameLabel)
        profileHeaderView.addSubview(profileHeaderView.statusLabel)
        profileHeaderView.addSubview(profileHeaderView.statusTextField)
        profileHeaderView.addSubview(profileHeaderView.statusButton)
        // добавим все элементы вью
        
        profileHeaderView.profileImageView.frame.origin = CGPoint(x: 16, y: 16)
        profileHeaderView.userNameLabel.frame.origin = CGPoint(x: profileHeaderView.profileImageView.frame.width + 32, y: 27)
        profileHeaderView.statusButton.frame.origin = CGPoint(x: 16, y: profileHeaderView.profileImageView.frame.maxY + 16 + 40)
        profileHeaderView.statusButton.frame.size = CGSize(width: profileHeaderView.frame.width - 32, height: 50)
        
            // изначально прописал зависимость UILabel статуса от положения кнопки по оси Y и отнял 34, чтобы совпадало с условием задачи (без звездочки), и значение менялось от размера аватарки (так как ее размер тоже не прописан), но выполняя задачу со звездочкой невозможно в расстояние 34 вместить UITextLabel высотой 40, еще и с отступами, поэтому размеры обозначил сам
        
        profileHeaderView.statusTextField.frame.origin = CGPoint(x: profileHeaderView.profileImageView.frame.width + 32, y: profileHeaderView.statusButton.frame.origin.y - 34 - 40)
        
        profileHeaderView.statusLabel.frame.origin = CGPoint(x: profileHeaderView.profileImageView.frame.width + 32, y: profileHeaderView.statusTextField.frame.minY - 32)
    }
    
    
}

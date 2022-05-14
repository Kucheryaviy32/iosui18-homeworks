import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let profileViewController = ProfileViewController()
        let feedViewController = FeedViewController()
        
        let profileNavigationVC = UINavigationController(rootViewController: profileViewController)
        let feedNavigationVC = UINavigationController(rootViewController: feedViewController)
        
        let tabBarController = UITabBarController()
                    
        profileNavigationVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile_icon"), selectedImage: UIImage(named: "profile_icon"))
       
        feedNavigationVC.tabBarItem = UITabBarItem(title: "Новости", image: UIImage(named: "feed_icon"), selectedImage: UIImage(named: "feed_icon"))
        
        profileNavigationVC.view.backgroundColor = .white
        feedNavigationVC.view.backgroundColor = .cyan
        
        tabBarController.viewControllers = [profileNavigationVC, feedNavigationVC]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }
}

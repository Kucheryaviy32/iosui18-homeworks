import UIKit
import StorageService

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let tabBarController = UITabBarController()
        
        let logInViewController = LogInViewController()
        
        let loginFactory = MyLoginFactory()
        logInViewController.delegate = loginFactory.createLoginInspector()
        
        let loginNavigationController = UINavigationController(rootViewController: logInViewController)
        tabBarController.viewControllers = [loginNavigationController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            
            let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
            }
        }
        
        return true
    }
}

import UIKit
import StorageService
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = UITabBarCoordinator()
        
        let tabBarController = rootCoordinator.startApp(authenticationData: nil)
        
        //        let appConfiguration = getRandomConfiguration()
        //        NetworkService.URLSessionDataTask(appConfiguration)
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .createColor(lightMode: .white, darkMode: .black)

        FirebaseApp.configure()
        
        return true
    }
    
    //    private func getRandomConfiguration() -> AppConfiguration {
    //          let array: [AppConfiguration] = [.species, .vehicles, .starships]
    //          return array[Int.random(in: 1...2)]
    //      }
    
}

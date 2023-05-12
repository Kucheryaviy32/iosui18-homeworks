//
//  TabBarController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 01.03.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    var coordinator: UITabBarCoordinator?
    var authenticationData: (userService: UserService, name: String)?
    //    var timer: Timer? = nil
    
    var activView: UITabBarCoordinator.action {
        didSet {
            switchApp()
        }
    }
    
    init(coordinator: UITabBarCoordinator, activView: UITabBarCoordinator.action, authenticationData: (userService: UserService, name: String)?) {
        self.coordinator = coordinator
        self.activView = activView
        self.authenticationData = authenticationData
        super.init(nibName: nil, bundle: nil)
        
        switch self.activView {
        case .autorization:
            self.tabBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
            let logInViewController = LogInViewController() {(authenticationData: (userService: UserService, name: String)) in
                self.authenticationData = authenticationData
                self.activView = .allApp
            }
            let loginFactory = MyLoginFactory()
            logInViewController.delegate = loginFactory.createLoginInspector()
            
            let loginNavigationController = UINavigationController(rootViewController: logInViewController)
            self.viewControllers = [loginNavigationController]
            self.tabBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)

            
        case .allApp:
            do {
                self.tabBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
                let feedCoordinator = FeedCoordinator()
                let feedNavigationController = try feedCoordinator.Start()
                let profileCoordinator = ProfileCoordinator(data: authenticationData!){
                    self.authenticationData = nil
                    self.activView = .autorization
                }
                let profileNavigationController = try profileCoordinator.Start()
                let favoriteCoordinator = FavoriteCoordinator()
                let favoriteNavigationController = try favoriteCoordinator.Start()
                let mapCoordinator = MapsCoordinator()
                let mapNavigationController = try mapCoordinator.Start()
                if let feedNavC = feedNavigationController,
                   let profileNavC = profileNavigationController,
                   let favNavC = favoriteNavigationController,
                   let mapNavC = mapNavigationController {
                    self.viewControllers = [profileNavC, feedNavC,  favNavC, mapNavC]
                }
            } catch {
                preconditionFailure("Критическая ошибка")
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchApp() {
        switch self.activView {
        case .autorization:
            
            let logInViewController = LogInViewController() {(authenticationData: (userService: UserService, name: String)) in
                self.authenticationData = authenticationData
                self.activView = .allApp
            }
            logInViewController.view.backgroundColor = .createColor(lightMode: .white, darkMode: .black)

            
            let loginFactory = MyLoginFactory()
            logInViewController.delegate = loginFactory.createLoginInspector()
            
            let loginNavigationController = UINavigationController(rootViewController: logInViewController)
            self.viewControllers = [loginNavigationController]
            
        case .allApp:
            do {
                let feedCoordinator = FeedCoordinator()
                let feedNavigationController = try feedCoordinator.Start()
                let profileCoordinator = ProfileCoordinator(data: authenticationData!){
                    self.authenticationData = nil
                    self.activView = .autorization
                }
                let profileNavigationController = try  profileCoordinator.Start()
                let favoriteCoordinator = FavoriteCoordinator()
                let favoriteNavigationController = try favoriteCoordinator.Start()
                let mapCoordinator = MapsCoordinator()
                let mapNavigationController = try mapCoordinator.Start()
                if let feedNavC = feedNavigationController,
                   let profileNavC = profileNavigationController,
                   let favNavC = favoriteNavigationController,
                   let mapNavC = mapNavigationController {
                    self.viewControllers = [profileNavC, feedNavC,  favNavC, mapNavC]
                }
            } catch {
                fatalError()
            }
        }
    }
    
}

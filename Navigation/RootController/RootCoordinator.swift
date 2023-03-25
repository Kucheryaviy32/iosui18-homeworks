//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Игорь Скворцов on 01.03.2023.
//

import Foundation
import UIKit

protocol RootCoordinator {
    func startApp(authenticationData: (userService: UserService, name: String)?) -> UIViewController
}

protocol VCCoordinator {
    var navigationController: UINavigationController? { get set }
    func Start() throws -> UINavigationController?
}

class UITabBarCoordinator: RootCoordinator {
    
    enum action {
        case autorization
        case allApp
    }
    
    func startApp(authenticationData: (userService: UserService, name: String)?) -> UIViewController {
        let tabBar = TabBarController(coordinator: self, activView: .autorization, authenticationData: authenticationData)
        tabBar.tabBar.backgroundColor = .white
        return tabBar
    }
    
}

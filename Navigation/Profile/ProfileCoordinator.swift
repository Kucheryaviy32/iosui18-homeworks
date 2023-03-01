//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Игорь Скворцов on 01.03.2023.
//

import Foundation
import UIKit

class ProfileCoordinator: VCCoordinator {

    var navigationController: UINavigationController?
    let userService: UserService?
    let name: String?

    init(data:(userService: UserService, name: String)) {
        self.userService = data.userService
        self.name = data.name
    }

    func Start() -> UINavigationController? {
        let factory = RootFactory(state: .profile)
        if let unRapUserService = userService, let unRapName = name {
            navigationController = factory.startModule(coordinator: self, data: (userService: unRapUserService, name: unRapName))
            return navigationController
        }
        return nil
    }
}
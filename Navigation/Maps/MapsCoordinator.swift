//
//  MapsCoordinator.swift
//  Navigation
//
//  Created by Игорь Скворцов on 10.04.2023.
//

import Foundation
import UIKit

 class MapsCoordinator: VCCoordinator {

     var navigationController: UINavigationController?

     func Start() throws -> UINavigationController? {
         let factory = RootFactory(state: .map)
         navigationController = factory.startModule(coordinator: self, data: nil)
         return navigationController
     }
 }

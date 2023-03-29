//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Игорь Скворцов on 29.03.2023.
//

import Foundation
import UIKit

 class FavoriteCoordinator: VCCoordinator {

     var navigationController: UINavigationController?

     func Start() throws -> UINavigationController? {
         let factory = RootFactory(state: .favorite)
         navigationController = factory.startModule(coordinator: self, data: nil)
         return navigationController
     }

     func showPost(_ post: FeedPost) {
         navigationController?.pushViewController(PostViewController(coordinator: self, post: post), animated: true)
     }

     func showInfo(_ title: String, people: [String]?) {
         navigationController?.present(InfoViewController(title: title, residentUrl: people), animated: true)
     }
 }

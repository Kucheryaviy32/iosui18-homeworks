//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Игорь Скворцов on 01.03.2023.
//

import Foundation
import UIKit

class FeedCoordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    
    func Start() -> UINavigationController? {
        let factory = RootFactory(state: .feed)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
    
    func pushPost(post: Post_old) {
        let postViewController = PostViewController(coordinator: self, post: post)
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func showInfoPost() {
        let infoViewController = InformationViewController()
        navigationController!.present(infoViewController, animated: true, completion: nil)
    }
    
}

//
//  RootFactory.swift
//  Navigation
//
//  Created by Игорь Скворцов on 01.03.2023.
//

import Foundation
import UIKit

final class RootFactory {
    
    enum State {
        case feed
        case profile
        case favorite
    }
    
    var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func startModule(coordinator: VCCoordinator, data: (userService: UserService, name: String)?) -> UINavigationController? {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        
        switch state {
        case .feed:
            let dataBaseCoordinator = CreateDataBase()
            let viewModel = FeedModel(coordinator: coordinator as! FeedCoordinator)
            let feedViewController = FeedViewController(coordinator: coordinator as! FeedCoordinator, model: viewModel, dbCoordinator: dataBaseCoordinator)
            feedViewController.view.backgroundColor = UIColor.white
            let feedNavigationController = UINavigationController(rootViewController: feedViewController)
            
            feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(named: "feed_icon"), selectedImage: UIImage(named: "feed_icon"))
            feedNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            feedNavigationController.navigationBar.barTintColor = UIColor.white
            feedNavigationController.navigationBar.standardAppearance = appearance;
            feedNavigationController.navigationBar.scrollEdgeAppearance = feedNavigationController.navigationBar.standardAppearance
            return feedNavigationController
            
        case .profile:
            
            if let userData = data {
                let profileViewController = ProfileViewController(coordinator: coordinator as! ProfileCoordinator, userService: userData.userService, name: userData.name)
                let profileNavigationController = UINavigationController(rootViewController: profileViewController)
                
                profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile_icon"), selectedImage: UIImage(named: "profile_icon"))
                profileNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
                profileNavigationController.navigationBar.barTintColor = UIColor.white
                profileNavigationController.navigationBar.standardAppearance = appearance;
                profileNavigationController.navigationBar.scrollEdgeAppearance = profileNavigationController.navigationBar.standardAppearance
                return profileNavigationController
            }
            
        case .favorite:
            let dataBaseCoordinator = CreateDataBase()
            let favoriteViewController = Favorite(coordinator: coordinator as! FavoriteCoordinator, dbCoordinator: dataBaseCoordinator)
            favoriteViewController.view.backgroundColor = UIColor.white
            let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
            favoriteNavigationController.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(named: "feed_icon"), selectedImage: UIImage(named: "feed_icon"))
            favoriteNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            favoriteNavigationController.navigationBar.barTintColor = UIColor.white
            favoriteNavigationController.navigationBar.standardAppearance = appearance;
            favoriteNavigationController.navigationBar.scrollEdgeAppearance = favoriteNavigationController.navigationBar.standardAppearance
            return favoriteNavigationController
        }
        return nil
    }
    


private func CreateDataBase() -> DatabaseCoordinatable {
    let bundle = Bundle.main
    guard let url = bundle.url(forResource: "PostCoreDataModel", withExtension: "momd") else {
        fatalError("Can't find DatabaseDemo.xcdatamodelId in main Bundle")
    }
    
    switch CoreDataCoordinator.create(url: url) {
    case .success(let database):
        return database
    case .failure:
        switch CoreDataCoordinator.create(url: url) {
        case .success(let database):
            return database
        case .failure(let error):
            fatalError("Unable to create CoreData Database. Error - \(error.localizedDescription)")
        }
    }
}
}

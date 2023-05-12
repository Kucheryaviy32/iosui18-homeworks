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
        case map
    }
    
    var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func startModule(coordinator: VCCoordinator, data: (userService: UserService, name: String)?) -> UINavigationController? {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
        
        switch state {
        case .feed:
            let dataBaseCoordinator = CreateDataBase()
            let viewModel = FeedModel(coordinator: coordinator as! FeedCoordinator)
            let feedViewController = FeedViewController(coordinator: coordinator as! FeedCoordinator, model: viewModel, dbCoordinator: dataBaseCoordinator)
            feedViewController.view.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
            let feedNavigationController = UINavigationController(rootViewController: feedViewController)
            
            feedNavigationController.tabBarItem = UITabBarItem(title: LocalizedService.getText(key: .feed), image: UIImage(named: "feed_icon"), selectedImage: UIImage(named: "feed_icon"))
            feedNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            feedNavigationController.navigationBar.barTintColor = .createColor(lightMode: .white, darkMode: .black)
            feedNavigationController.navigationBar.standardAppearance = appearance;
            feedNavigationController.navigationBar.scrollEdgeAppearance = feedNavigationController.navigationBar.standardAppearance
            return feedNavigationController
            
        case .profile:
            
            if let userData = data {
                let profileViewController = ProfileViewController(coordinator: coordinator as! ProfileCoordinator, userService: userData.userService, name: userData.name)
                let profileNavigationController = UINavigationController(rootViewController: profileViewController)
                
                profileNavigationController.tabBarItem = UITabBarItem(title: LocalizedService.getText(key: .profile), image: UIImage(named: "profile_icon"), selectedImage: UIImage(named: "profile_icon"))
                profileNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
                profileNavigationController.navigationBar.barTintColor = .createColor(lightMode: .white, darkMode: .black)
                profileNavigationController.navigationBar.standardAppearance = appearance;
                profileNavigationController.navigationBar.scrollEdgeAppearance = profileNavigationController.navigationBar.standardAppearance
                return profileNavigationController
            }
            
        case .favorite:
            let dataBaseCoordinator = CreateDataBase()
            let favoriteViewController = Favorite(coordinator: coordinator as! FavoriteCoordinator, dbCoordinator: dataBaseCoordinator)
            favoriteViewController.view.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
            let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
            favoriteNavigationController.tabBarItem = UITabBarItem(title: LocalizedService.getText(key: .favorite), image: UIImage(named: "feed_icon"), selectedImage: UIImage(named: "feed_icon"))
            favoriteNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            favoriteNavigationController.navigationBar.barTintColor = .createColor(lightMode: .white, darkMode: .black)
            favoriteNavigationController.navigationBar.standardAppearance = appearance;
            favoriteNavigationController.navigationBar.scrollEdgeAppearance = favoriteNavigationController.navigationBar.standardAppearance
            return favoriteNavigationController
            
            
        case .map:
            
            let mapViewController = MapsViewController()
            mapViewController.view.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
            let mapNavigationController = UINavigationController(rootViewController: mapViewController)
            
            mapNavigationController.tabBarItem = UITabBarItem(title: LocalizedService.getText(key: .maps), image: UIImage(named: "feed_icon"), selectedImage: UIImage(named: "feed_icon"))
            mapNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            mapNavigationController.navigationBar.barTintColor = .createColor(lightMode: .white, darkMode: .black)
            mapNavigationController.navigationBar.standardAppearance = appearance;
            mapNavigationController.navigationBar.scrollEdgeAppearance = mapNavigationController.navigationBar.standardAppearance
            return mapNavigationController
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

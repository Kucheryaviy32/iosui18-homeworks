//
//  UserData.swift
//  Navigation
//
//  Created by Игорь Скворцов on 27.10.2022.
//

import Foundation
import UIKit

class User {
    
    let logIn : String
    let name : String
    let avatar : UIImage?
    let status : String
    
    init(login: String, name: String, avatar: UIImage?, status: String) {
        self.logIn = login
        self.name = name
        self.avatar = avatar
        self.status = status
    }
    
}

protocol UserService {
    
    var user : User { get }
    func getUser(login: String) -> User?
}

public class CurrentUserService : UserService {
    
    var user: User = User(login: "Rick",
                          name: "Рик Санчез",
                          avatar: UIImage(named: "ProfileImage"),
                          status: "В ожидании 7 серии")
    func getUser(login: String) -> User? {
        login == user.logIn ? user : nil
    }
}


final class TestUserService : UserService {
    var user = User(login: "Test",
                    name: "Тестировщик",
                    avatar: UIImage(named: "morty"),
                    status: "Похоже все работает")
    
    func getUser(login: String) -> User? {
        login == user.logIn ? user : nil
    }
}

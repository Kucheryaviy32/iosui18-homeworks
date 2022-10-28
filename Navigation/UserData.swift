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
    
    var user : User? { get }
    func getUser(login: String) -> User?
    var accept : Bool { get }
}

public class CurrentUserService : UserService {
    
   var user: User? = User(login: "Rick", name: "Рик Санчез", avatar: UIImage(named: "ProfileImage"), status: "В ожидании 7 серии")
   public var accept: Bool = false

    // Понимаю что сделал скорее всего все криво, но пока для наглядности прописал все без иницилизатора
    
    func getUser(login: String) -> User? {
        if let activeUser = user {
            if login == activeUser.logIn {
                accept = true
                return user
            }
        }
        return nil
    }

}
    

public class TestUserService : UserService {
    public var accept: Bool = false
    var user : User? = User(login: "Test", name: "Тестировщик", avatar: UIImage(named: "morty"), status: "Похоже все работает")
    
    func getUser(login: String) -> User? {
        if let activeUser = user{
            if login == activeUser.logIn {
            accept = true
            return user
            }
        }
        return nil
    }
}

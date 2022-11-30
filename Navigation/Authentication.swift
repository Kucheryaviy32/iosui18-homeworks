//
//  Authentication.swift
//  Navigation
//
//  Created by Игорь Скворцов on 29.11.2022.
//

import Foundation

 protocol LoginViewControllerDelegate: AnyObject {

     func checkPassword(login: String, password: String) -> Bool
 }

 class LoginInspector: LoginViewControllerDelegate  {

     func checkPassword(login: String, password: String) -> Bool {
         Checker.shared.checkUserData(checkLogin: login.hash, checkPassword: password.hash)
     }

 }

 class Checker {

     static let shared: Checker = {
        Checker()
     }()
#if DEBUG
     private let login = "Test".hash
     private let pswd = "Test".hash
#else
     private let login = "Rick".hash
     private let pswd = "Sanchez".hash
#endif
   

     private init() {}

     public func checkUserData(checkLogin: Int, checkPassword: Int) -> Bool {
         checkLogin == login && checkPassword == pswd
     }

 }

 protocol LoginFactory {
     func createLoginInspector() -> LoginViewControllerDelegate
 }

 class MyLoginFactory: LoginFactory {
     func createLoginInspector() -> LoginViewControllerDelegate {
         LoginInspector()
     }
 }

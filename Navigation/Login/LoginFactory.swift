//
//  LoginFactory.swift
//  Navigation
//
//  Created by Игорь Скворцов on 20.03.2023.
//

import Foundation

protocol LoginFactory {
    func createLoginInspector() -> LoginViewControllerDelegate
}

class MyLoginFactory: LoginFactory {
    func createLoginInspector() -> LoginViewControllerDelegate {
        LoginInspector()
    }
}

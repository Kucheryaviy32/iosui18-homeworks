//
//  LocalizedService.swift
//  Navigation
//
//  Created by Игорь Скворцов on 13.04.2023.
//

import Foundation

class LocalizedService {
    enum Keys: String {
        case favorite = "favorites"
        case feed = "feed"
        case info = "info"
        case sputnikView = "sputnikView"
        case schematicView = "schematicView"
        case maps = "maps"
        case insertLogIn = "insertLogIn"
        case insertPassword = "insertPassword"
        case logIn = "logIn"
        case regIn = "regIn"
        case insertNewStatus = "insertNewStatus"
        case changeStatus = "changeStatus"
        case likes = "likes"
        case views = "views"
        case photos = "photos"
        case photoGallery = "photoGallery"
        case profile = "profile"
    }
    
    static func getText(key: Keys, numeric: Int? = nil) -> String {
        var string = NSLocalizedString(key.rawValue, comment: "")
        if let numeric = numeric {
            string = String.localizedStringWithFormat(string, numeric)
        }
        return string
    }
}

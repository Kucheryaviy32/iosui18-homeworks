//
//  General.swift
//  Navigation
//
//  Created by Игорь Скворцов on 15.12.2022.
//

import UIKit


let constPhotoArray = [UIImage(named:"Photo1")!,
                       UIImage(named:"Photo2")!,
                       UIImage(named:"Photo3")!,
                       UIImage(named:"Photo4")!,
                       UIImage(named:"Photo5")!,
                       UIImage(named:"Photo6")!,
                       UIImage(named:"Photo8")!,
                       UIImage(named:"Photo9")!,
                       UIImage(named:"Photo10")!,
                       UIImage(named:"Photo11")!,
                       UIImage(named:"Photo12")!,
                       UIImage(named:"Photo13")!,
                       UIImage(named:"Photo14")!,
                       UIImage(named:"Photo15")!,
                       UIImage(named:"Photo16")!,
                       UIImage(named:"Photo17")!,
                       UIImage(named:"Photo18")!,
                       UIImage(named:"Photo19")!,
                       UIImage(named:"Photo20")!]

enum AppError: Error {
    case unauthorized
    case notFound
    case badData
    case internalServer
}

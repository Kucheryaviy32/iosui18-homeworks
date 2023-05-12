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

extension NSNotification.Name {
    static let wasLikedPost = NSNotification.Name("wasLikedPost")
    static let didRemovePostFromFavorites = NSNotification.Name("didRemovePostFromFavorites")
}

extension String {
    
    static let empty = ""
    static let whitespace: Character = " "
    
    var isFirstCharacterWhitespace: Bool {
        return self.first == Self.whitespace
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func replace(_ pattern: String, replacement: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        return regex.stringByReplacingMatches(in: self,
                                              options: [.withTransparentBounds],
                                              range: NSRange(location: 0, length: self.count),
                                              withTemplate: replacement)
    }
    
    static func randomString(length: Int = 36) -> Self {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).compactMap { _ in letters.randomElement() })
    }
}

struct Const {
    
    static let leadingMargin: CGFloat = 16
    static let trailingMargin: CGFloat = -16
    static let indent: CGFloat = 16
    static let smallIndent: CGFloat = 8
    static let smallSize: CGFloat = 20
    static let size: CGFloat = 50
    static let bigSize: CGFloat = 100
    static let bigIndent: CGFloat = 120
    
}

public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
}

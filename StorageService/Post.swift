//
//  Post.swift
//  Navigation
//
//  Created by Игорь Скворцов on 17.03.2022.
//

import Foundation
import UIKit


public struct Post {
   public var author : String
    public var description : String
    public  var image: UIImage
    public  var likes: Int
    public  var views: Int
    
   public static func postFeed() -> [Post] {
        var post = [Post]()
        post.append(Post(author: "Морти", description: "Ого, где это мы, Рик?", image: UIImage(named: "morty")!, likes: 132, views: 1231))
        post.append(Post(author: "Гомер", description: "Нельзя строить отношения на лжи. Ложь приходит потом.", image: UIImage(named: "gomer")!, likes: 132, views: 1412))
        post.append(Post(author: "Леонард", description: "Шелдон - самое ужасное гениальное создание на Земле!", image: UIImage(named: "leonard")!, likes: 1231, views: 1231))
        post.append(Post(author: "Капитан Джек Воробей", description: "Стоит разок умереть и приоритеты тут же меняются", image: UIImage(named: "dzhek")!, likes: 454, views: 3533))

        return post
    }
}


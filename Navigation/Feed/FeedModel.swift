//
//  FeedModel.swift
//  Navigation
//
//  Created by Игорь Скворцов on 01.03.2023.
//

import Foundation

class FeedModel {

    weak var coordinator: FeedCoordinator?

    init(coordinator:FeedCoordinator){
        self.coordinator = coordinator
    }

    func check(word: String) -> Bool {
            return word == "Green"
    }

    func getPost(sender: CustomButton) {
        let post = Post_old(title: sender.title(for: .normal)!)
        coordinator!.pushPost(post: post)
    }

}

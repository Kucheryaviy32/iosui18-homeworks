//
//  PostCollectionViewCell.swift
//  Navigation
//
//  Created by Игорь Скворцов on 29.03.2023.
//

import Foundation
import UIKit
import StorageService

protocol PostCollectionViewCellDelegate: AnyObject {
    func tapToPost(with post: FeedPost, isFavorite: Bool)
    func showPost(post: FeedPost)
}

class PostCollectionViewCell: UICollectionViewCell {

    static let identifire = "PostCollectionViewCell"
    weak var delegate: PostCollectionViewCellDelegate?
    var post: FeedPost?
    var isFavorite = false
    
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.isUserInteractionEnabled = true
        return photo
    }()
    
    let like: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubviews(photo, like)
        
        let firstTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        firstTapGestureRecognizer.numberOfTapsRequired = 1
        firstTapGestureRecognizer.numberOfTouchesRequired = 1
        firstTapGestureRecognizer.isEnabled = true
        
        
        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapped))
        secondTapGestureRecognizer.numberOfTapsRequired = 2
        secondTapGestureRecognizer.numberOfTouchesRequired = 1
        secondTapGestureRecognizer.isEnabled = true
        contentView.isUserInteractionEnabled = true
        firstTapGestureRecognizer.require(toFail: secondTapGestureRecognizer)
        contentView.addGestureRecognizer(firstTapGestureRecognizer)
        contentView.addGestureRecognizer(secondTapGestureRecognizer)
        
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([photo.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     like.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: -5),
                                     like.trailingAnchor.constraint(equalTo: photo.trailingAnchor, constant: -5),
                                     like.heightAnchor.constraint(equalToConstant: 10)
                                    ])
    }
    
    func setupPost(_ post: FeedPost, isFavorite: Bool) {
        self.post = post
        photo.image = post.image
        self.isFavorite = isFavorite
        if isFavorite {
            like.text = "❤️"
        } else {
            like.text = "🖤"
        }
    }
    
    @objc func imageTapped()
    {
        if let delegate = delegate, let post = post {
            delegate.showPost(post: post)
        }
    }
    
    @objc func imageDoubleTapped()
    {
        if let delegate = delegate, let post = post {
            delegate.tapToPost(with: post, isFavorite: isFavorite)
        }
    }
    
}


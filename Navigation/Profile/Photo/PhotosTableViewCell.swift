//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Игорь Скворцов on 15.12.2022.
//

import UIKit
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    
    static let identifire = "PhotosTableViewCell"
    
    let imageProcessor  = ImageProcessor()
    
    private let contentPhotoView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        
        return stackView
        
    }()
    
    let titleLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Фотографии"
        photosLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photosLabel.textColor = .black
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        return photosLabel
    }()
    
    let titleButton: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        return arrowImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [stackView, titleLabel, titleButton].forEach {contentView.addSubview($0)}
        
        for i in 0...3 {
            
            let photo = UIImageView(image: constPhotoArray[i])
            photo.translatesAutoresizingMaskIntoConstraints = false
            photo.layer.cornerRadius = 6
            photo.clipsToBounds = true
            stackView.addArrangedSubview(photo)
        }
        
        useConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            titleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleButton.heightAnchor.constraint(equalToConstant: 30),
            titleButton.widthAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
        ])
        stackView.arrangedSubviews.forEach(
            {
                [$0.widthAnchor.constraint(greaterThanOrEqualToConstant: (stackView.frame.width - 16) / 4),
                 $0.heightAnchor.constraint(equalTo: $0.widthAnchor)].forEach({$0.isActive = true})
                
            })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

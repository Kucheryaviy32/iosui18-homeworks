//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Игорь Скворцов on 15.12.2022.
//


import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let imagePublisherFacade = ImagePublisherFacade()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var contentPhotoData: [UIImage] = []
    var timerCount = 0.0
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = LocalizedService.getText(key: .photoGallery)
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifire)
        useConstraint()
        
        let imageProcessor = ImageProcessor()
        imageProcessor.processImagesOnThread(sourceImages: constPhotoArray, filter: .chrome, qos: .background) {cgImages in
            let images = cgImages.map({UIImage(cgImage: $0!)})
            self.contentPhotoData.removeAll()
            images.forEach({self.contentPhotoData.append($0)})
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        /*
         .default - 0.6800000000000004 сек
         .background - 2.719999999999986 сек
         .userInitiated - 0.6900000000000004 сек
         .userInteractive - 0.6900000000000004 сек
         .utility - 0.6800000000000004 сек
         */
    }
    
    @objc func updateTimer() {
        timerCount += 0.01
        if contentPhotoData.count > 0 {
            print("Потрачено \(self.timerCount) секунд")
            timer!.invalidate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentPhotoData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifire, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.setupImage(contentPhotoData[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 40) / 3, height: (collectionView.frame.width - 40) / 3)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        
        images.forEach({ image in
            if contentPhotoData.contains(where: {image == $0}) {
                return
            }
            else {
                contentPhotoData.append(image)
            }
        })
        collectionView.reloadData()
        
    }
    
}

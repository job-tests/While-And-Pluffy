//
//  FavouritePhotoViewController.swift
//  TestPhotoApp
//
//  Created by Kirill Drozdov on 04.06.2022.
//

import UIKit
import RealmSwift

class FavouritePhotoViewController: UIViewController {
    
    var photo: FavouritePhoto!{
        didSet {
            guard let photoURL = URL(string: photo.photoUrl) else {return}
            imageView.sd_setImage(with: photoURL, completed: nil)
            usernameLabel.text = "Создатель: \(photo.userName)"
            createdAtLabel.text = "Дата: \(photo.createdAT)"
        }
    }
    
    lazy private var imageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = .white
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    lazy private var createdAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 17)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUPViewElements()
    }

    func setUPViewElements(){
        [imageView, usernameLabel, createdAtLabel].forEach(view.addSubview(_:))

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3)
        ])

        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            usernameLabel.widthAnchor.constraint(greaterThanOrEqualTo: imageView.widthAnchor, multiplier: 1/3),
            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            usernameLabel.heightAnchor.constraint(equalToConstant: 25),
        ])

        NSLayoutConstraint.activate([
            createdAtLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            createdAtLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
            createdAtLabel.widthAnchor.constraint(greaterThanOrEqualTo: imageView.widthAnchor, multiplier: 1/3),
            createdAtLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}

//
//  DetailViewController.swift
//  TestPhotoApp
//
//  Created by Kirill Drozdov on 04.06.2022.
//

import UIKit
import Foundation
import RealmSwift
import SwiftUI

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var photo: PhotoData! {
        didSet {
            let photoUrl = photo.urls["regular"]
            guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
            imageView.sd_setImage(with: url, completed: nil)
            usernameLabel.text = "Создатель: \(photo.user.username)"
            createdAtLabel.text = "Дата \(dateFormatter.string(from: photo.createdAt))"
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
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUPViewElements()
        updateButtonImage()
    }
    
    @objc private func likeButtonPressed() {
        photo.isFavourite.toggle()
        updateButtonImage()
        let favouritePhoto = FavouritePhoto()
        favouritePhoto.userName = photo.user.username
        favouritePhoto.createdAT = dateFormatter.string(from: photo.createdAt)
        favouritePhoto.photoUrl = photo.urls["regular"]!
        favouritePhoto.isFavourite = photo.isFavourite
        //        navigationController?.popViewController(animated: true)
        if photo.isFavourite {
            saveObject(photo: favouritePhoto)
        } else {
            deleteObject(photo: favouritePhoto)
        }
    }
    
    // MARK: RealmMethods
    private func saveObject(photo: FavouritePhoto) {
        do {
            try self.realm.write({
                self.realm.add(photo)
            })
            presentSuccessSaveAlert()
        } catch {
            print(error.localizedDescription)
            presentUnsuccsessSaveAlert()
        }
    }
    
    private func deleteObject(photo: FavouritePhoto) {
        let predicate = NSPredicate(format: "photoUrl=%@", photo.photoUrl)
        do{
            try realm.write({
                realm.delete(realm.objects(FavouritePhoto.self).filter(predicate))
            })
            presentSuccessDeleteAlert()
        }catch let error {
            print(error.localizedDescription)
            presentUnsuccsessDeleteAlert()
        }
    }


    private func setUPViewElements(){
        [imageView, usernameLabel, createdAtLabel, likeButton].forEach(view.addSubview(_:))

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

        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 45),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButton.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 5),
        ])
    }
}

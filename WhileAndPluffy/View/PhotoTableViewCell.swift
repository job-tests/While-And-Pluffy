//
//  PhotoTableViewCell.swift
//  WhileAndPluffy
//
//  Created by Kirill Drozdov on 04.06.2022.
//


import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {


    static let reuseID = "Cell"


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViewElements()
    }


    lazy private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy private var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    var photo: FavouritePhoto!{
        didSet {
            guard let photoURL = URL(string: photo.photoUrl) else {return}
            photoImageView.sd_setImage(with: photoURL, completed: nil)
            userNameLabel.text = "Создал: \(photo.userName)"
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }

    private func setUpViewElements(){

        [photoImageView,userNameLabel].forEach(self.addSubview(_:))

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            userNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 250),
            userNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            userNameLabel.topAnchor.constraint(equalTo: topAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

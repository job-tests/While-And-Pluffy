//
//  Alert.swift
//  WhileAndPluffy
//
//  Created by Kirill Drozdov on 04.06.2022.
//

import UIKit

extension DetailViewController {
    func presentSuccessSaveAlert() {
        let allertController = UIAlertController(title: "Фотография сохранена", message: "Ваше фото успешно сохранено", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }

    func presentUnsuccsessSaveAlert() {
        let allertController = UIAlertController(title: "Фото не сохранилось", message: "Что-то пошло не так", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }

    func presentSuccessDeleteAlert() {
        let allertController = UIAlertController(title: "Фотография была удалена", message: "Ваше фото успешно удалено", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }

    func presentUnsuccsessDeleteAlert() {
        let allertController = UIAlertController(title: "Фото не было удалено", message: "Что-то пошло не так", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }

    func updateButtonImage(){
        let imageName = photo.isFavourite ? "heart.fill" : "heart"
        let buttonImage = UIImage(systemName: imageName)
        likeButton.setBackgroundImage(buttonImage, for: .normal)
    }

}

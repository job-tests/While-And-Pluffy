//
//  MainViewController.swift
//  TestPhotoApp
//
//  Created by Kirill Drozdov on 04.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let firstViewController = FirstViewController(collectionViewLayout: WaterfallLayout())
        let secondViewConroller = SecondTableViewController()
        
        viewControllers = [
            setUpNavigationController(title: "Лента",
                                      image: UIImage(systemName: "photo.on.rectangle.angled"),
                                      rootViewController: firstViewController),
            setUpNavigationController(title: "Понравилось",
                                      image: UIImage(systemName: "heart.fill"),
                                      rootViewController: secondViewConroller)
        ]
    }
    
    private func setUpNavigationController(title: String, image: UIImage?, rootViewController: UIViewController) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        return navigationViewController
    }

    private func navigationControllerPreference(){
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}



//
//  MainCollectionViewController.swift
//  TestPhotoApp
//
//  Created by Kirill Drozdov on 04.06.2022.
//

import UIKit
import LoremSwiftum


class FirstViewController: UICollectionViewController {
    
    private var nerworkDataManager = NetworkDataManager()
    private var timer: Timer?
    private var photos = [PhotoData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        randomSearch()
        collectionView.backgroundColor = .white
        congfigureCollectionView()
        setUpSearchBar()
        title = "Лента"
    }
    
    
    
    private func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func congfigureCollectionView() {
        self.collectionView!.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseID)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        if let watefallLayut = collectionViewLayout as? WaterfallLayout {
            watefallLayut.delegate = self
        }
    }
    
    private func setUpSearchBar(){
        let searchConroller = UISearchController(searchResultsController: nil)
        searchConroller.searchBar.placeholder = "Search photo"
        searchConroller.obscuresBackgroundDuringPresentation = false
        searchConroller.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchConroller
    }
    
    private func randomSearch(){
        self.nerworkDataManager.fetchImages(searchKeyWord: Lorem.words(10)) { [weak self] data in
            guard let data = data else { return }
            self?.photos = data.results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseID, for: indexPath) as! PhotosCollectionViewCell
        let photo = photos[indexPath.item]
        cell.photo = photo
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        guard let imageData = cell.photo else { return }
        let detailVC = DetailViewController()
        detailVC.photo = imageData
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


// MARK: UISearchBarDelegate
extension FirstViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.nerworkDataManager.fetchImages(searchKeyWord: searchText) { [weak self] data in
                guard let data = data else { return }
                self?.photos = data.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
    }
}


extension FirstViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        let photo = photos[indexPath.item]
        return CGSize(width: photo.width, height: photo.height)
    }
}

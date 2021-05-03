//
//  FavouriteVC.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import UIKit
import SDWebImage

class FavouriteVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var vwCollectionFavourties: UICollectionView!
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavourties()
    }
    
    //MARK:- Actions
    @IBAction func btnRemoveFavourtieAction(_ sender: UIButton) {
        sender.animation()
        let params = DeleteFavouriteBody()
        params.favouriteId = Globals.arrFavouriteCatsImages[sender.tag].id!
        ServerManager.deleteFavourite(params: params) { (status) in
            if status == "success" {
                self.vwCollectionFavourties.reloadData()
                self.getFavourties()
            }
            else {
                self.showAlert(message: status)
            }
        }
    }
    
    // MARK: - Functions
    func getFavourties() {
        let params = FavourtieBody()
        params.subId = Constants.UDID!
        ServerManager.getFavourites(params: params) { (status, data) in
            if status == "success" {
                Globals.arrFavouriteCatsImages = data
                self.vwCollectionFavourties.reloadData()
            }
            else {
                self.showAlert(message: status)
            }
        }
    }
}

//MARK:- UICollectionView DataSource
extension FavouriteVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Globals.arrFavouriteCatsImages == nil ? 0 : Globals.arrFavouriteCatsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favouriteCatsCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCatsCCell", for: indexPath) as! FavouriteCatsCCell
        favouriteCatsCCell.btnRemoveFavourite.tag = indexPath.row
        favouriteCatsCCell.imgCat.sd_imageIndicator = SDWebImageActivityIndicator.large
        favouriteCatsCCell.imgCat.sd_setImage(with: URL(string: Globals.arrFavouriteCatsImages[indexPath.row].image?.url ?? ""), placeholderImage: UIImage(named: "placeholder"))
        return favouriteCatsCCell
    }
}

//MARK:- UICollectionView Delegate and Flowlayout
extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/3)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


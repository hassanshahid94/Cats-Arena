//
//  FavouriteCatsCCell.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import UIKit

class FavouriteCatsCCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var imgCat: UIImageView!
    @IBOutlet weak var btnRemoveFavourite: UIButton!
    
    //MARK:- Load
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
        
    }
    
    //MARK: Functions
    func initViews() {
        vwBackground.layer.cornerRadius = 10
        vwBackground.dropShadow(scale: false)
        imgCat.layer.cornerRadius = 7
        btnRemoveFavourite.layer.cornerRadius = 7
    }
}

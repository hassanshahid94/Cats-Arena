//
//  HomeCatsCCell.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import UIKit

class HomeCatsTCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblBreedName: UILabel!
    @IBOutlet weak var imgCat: UIImageView!
    @IBOutlet weak var vwBackground: UIView!
    
    //MARK:- Load
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Actions
    @IBAction func btnAddRemoveFavourtieAction(_ sender: UIButton) {
        btnFavourite.animation()
    }
    
    //MARK: Functions
    func initViews() {
        vwBackground.layer.cornerRadius = 10
        vwBackground.dropShadow(scale: false)
        imgCat.layer.cornerRadius = 7
    }
}

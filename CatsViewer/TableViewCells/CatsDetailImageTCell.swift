//
//  CatsDetailTCell.swift
//  CatsViewer
//
//  Created by Hassan on 19.4.2021.
//

import UIKit

class CatsDetailImageTCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var imgCat: UIImageView!
    
    //MARK:- Load
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView()
    {
        imgCat.layer.cornerRadius = 7
    }

}

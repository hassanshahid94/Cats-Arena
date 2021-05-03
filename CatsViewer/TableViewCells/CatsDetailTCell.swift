//
//  CatsDetailTCell.swift
//  CatsViewer
//
//  Created by Hassan on 19.4.2021.
//

import UIKit

class CatsDetailTCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    
    //MARK:- Load
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

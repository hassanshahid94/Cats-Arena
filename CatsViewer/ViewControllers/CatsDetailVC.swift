//
//  CatsDetailVC.swift
//  CatsViewer
//
//  Created by Hassan on 19.4.2021.
//

import UIKit
import SDWebImage

class CatsDetailVC: BaseVC {
    
    //MARK:- Variables
    var index: Int!
    
    // MARK: - Outlets
    @IBOutlet weak var tblCatsDetail: UITableView!
    @IBOutlet weak var btnAddFavourite: UIButton!
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: - Actions
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnAddFavouriteAction(_ sender: UIButton) {
        
        btnAddFavourite.animation()
        if !Globals.arrAllCatsImages[index].isFavourtie
        {
            let params = AddFavouriteBody()
            params.imageId = Globals.arrAllCatsImages[index].id
            params.subId = Constants.UDID
            ServerManager.addFavourite(params: params) { (status, data) in
                if status == "success"
                {
                    Globals.arrAllCatsImages[self.index].favouriteId = data?.id
                    Globals.arrAllCatsImages[self.index].isFavourtie = true
                    
                    self.btnAddFavourite.setImage(UIImage(named: "filled heart"), for: .normal)
                }
                else
                {
                    self.showAlert(message: status)
                }
            }
        }
        else
        {
            let params = DeleteFavouriteBody()
            params.favouriteId = Globals.arrAllCatsImages[index].favouriteId
            
            ServerManager.deleteFavourite(params: params) { (status) in
                if status == "success"
                {
                    Globals.arrAllCatsImages[self.index].favouriteId = nil
                    Globals.arrAllCatsImages[self.index].isFavourtie = false
                    self.btnAddFavourite.setImage(UIImage(named: "favourite"), for: .normal)
                }
                else{
                    self.showAlert(message: status)
                }
            }
        }
        
    }
    
    //MARK:- Functions
    func initView()
    {
        if Globals.arrAllCatsImages[index].isFavourtie
        {
            btnAddFavourite.setImage(UIImage(named: "filled heart"), for: .normal)
        }
        else
        {
            btnAddFavourite.setImage(UIImage(named: "favourite"), for: .normal)
        }
    }
}

//MARK:- UITableView DataSource
extension CatsDetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let catsDetailTCell = tableView.dequeueReusableCell(withIdentifier: "CatsDetailTCell", for: indexPath) as! CatsDetailTCell
        
        if indexPath.row == 0
        {
            let catsDetailImageTCell = tableView.dequeueReusableCell(withIdentifier: "CatsDetailImageTCell", for: indexPath) as! CatsDetailImageTCell
            
            catsDetailImageTCell.imgCat.sd_imageIndicator = SDWebImageActivityIndicator.large
            catsDetailImageTCell.imgCat.sd_setImage(with: URL(string: Globals.arrAllCatsImages[index].url ?? ""), placeholderImage: UIImage(named: "placeholder"))
            
            return catsDetailImageTCell
        }
        else if indexPath.row == 1
        {
            catsDetailTCell.lblHeading.text = "ID:"
            catsDetailTCell.lblDetail.text = Globals.arrAllCatsImages[index].id ?? "Not Available"
        }
        else if indexPath.row == 2
        {
            catsDetailTCell.lblHeading.text = "Breed:"
            catsDetailTCell.lblDetail.text = Globals.arrAllCatsImages[index].breeds?.first?.name ?? "Not Available"
        }
        else if indexPath.row == 3
        {
            catsDetailTCell.lblHeading.text = "Origin:"
            catsDetailTCell.lblDetail.text = Globals.arrAllCatsImages[index].breeds?.first?.origin ?? "Not Available"
        }
        else if indexPath.row == 4
        {
            catsDetailTCell.lblHeading.text = "Life span:"
            catsDetailTCell.lblDetail.text = Globals.arrAllCatsImages[index].breeds?.first?.lifeSpan ?? "Not Available"
        }
        else
        {
            catsDetailTCell.lblHeading.text = "Description:"
            catsDetailTCell.lblDetail.text = Globals.arrAllCatsImages[index].breeds?.first?.descriptionField ?? "Not Available"
        }
        return catsDetailTCell
    }
}

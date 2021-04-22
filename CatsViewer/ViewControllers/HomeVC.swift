//
//  HomeVC.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import UIKit
import SDWebImage
import LNFloatingActionButton
import DropDown
import LoadingPlaceholderView
import DataCache
import SwiftyJSON

class HomeVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- Variables
    var spinner = UIActivityIndicatorView(style: .medium)
    var isFirstLoad = false
    var arrCheckNextPageCats = [CatsViewerAllCatsResponse]()
    var pageNumber = 0
     
     var picker = UIImagePickerController()
     var btnFloatingCells: [LNFloatingActionButtonCell] = []
    
     var filter = DropDown()
     var breedId = ""
    
    var refreshControl = UIRefreshControl()
    
    private var loadingPlaceholderView = LoadingPlaceholderView()
    private var cellsIdentifiers = [
        "HomeCatsTCell",
        "HomeCatsTCell",
        "HomeCatsTCell",
        "HomeCatsTCell",
        "HomeCatsTCell",
        "HomeCatsTCell"
    ]
    
    //MARK:- Outlets
    @IBOutlet weak var tblAllCats: UITableView!{
        didSet {
            tblAllCats.coverableCellsIdentifiers = cellsIdentifiers
        }
    }
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnClearFilter: UIButton!
    
    //MARK:- Load
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getAlllCats()
        getBreeds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavourites()
    }
    
    // MARK: - Actions
    @IBAction func btnFilterAction(_ sender: UIButton) {
        filter.show()
    }
    @IBAction func btnClearFilterAction(_ sender: UIButton) {
        setupLoadingPlaceholderView()
        performFakeNetworkRequest()
        btnClearFilter.isHidden = true
        breedId = ""
        getAlllCats()
    }
    
    @IBAction func btnAddFavourite(_ sender: UIButton) {
        
        let params = AddFavouriteBody()
        params.imageId = Globals.arrAllCatsImages[sender.tag].id!
        params.subId = Constants.UDID!
        
        
        if !Globals.arrAllCatsImages[sender.tag].isFavourtie {
            
            //Add to favourites
            ServerManager.addFavourite(params: params) { (status, data) in
                if status == "success"
                {
                    Globals.arrAllCatsImages[sender.tag].isFavourtie = true
                    Globals.arrAllCatsImages[sender.tag].favouriteId = data?.id
                    sender.setImage(UIImage(named: "filled heart"), for: .normal)
                    self.getFavourites()
                }
                else
                {
                    self.showAlert(message: status)
                }
            }
        }
        
        else {
            //Delete From Favourties
            let params = DeleteFavouriteBody()
            params.favouriteId = Globals.arrAllCatsImages[sender.tag].favouriteId
            ServerManager.deleteFavourite(params: params) { (status) in
                if status == "success"
                {
                    Globals.arrAllCatsImages[sender.tag].isFavourtie = false
                    Globals.arrAllCatsImages[sender.tag].favouriteId = nil
                    sender.setImage(UIImage(named: "favourite"), for: .normal)
                    self.getFavourites()
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
        //Showing palceholder on the tableview
        setupLoadingPlaceholderView()
        performFakeNetworkRequest()
        
        //pull to refresh tableview
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblAllCats.addSubview(refreshControl)
        
        // Action triggered on selection filter
        filter.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnClearFilter.isHidden = false
            self.breedId = Globals.arrCatsBreeds[index].id!
            self.pageNumber = 0
            setupLoadingPlaceholderView()
            performFakeNetworkRequest()
            self.getAlllCats()
        }

        // Will set a custom width instead of the anchor view width
        filter.width = 200
        
        picker.delegate = self
        
        //adding Floating button
        let btnGallery: LNFloatingActionButtonCell = {
           let cell = LNFloatingActionButtonCell()
            cell.size = 45
            cell.color = UIColor.CatsViewer_tabBar_Selection
            cell.image = UIImage(named: "gallery")
            return cell
        }()
        btnFloatingCells.append(btnGallery)
        
        let btnCamera: LNFloatingActionButtonCell = {
           let cell = LNFloatingActionButtonCell()
            cell.size = 45
            cell.color = UIColor.CatsViewer_tabBar_Selection
            cell.image = UIImage(named: "camera")
            return cell
        }()
        btnFloatingCells.append(btnCamera)
        
        
        let btnFloating: LNFloatingActionButton = {
            let button = LNFloatingActionButton(x: view.frame.size.width - 70, y: view.frame.size.height - (UIApplication.shared.windows[0].safeAreaInsets.bottom + 150))
            button.delegate = self
            button.dataSource = self
            button.size = 55
            button.color = .white
            button.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.shadowOpacity = 0.5
            button.shadowRadius = 2.0
            button.shadowPath = button.circlePath
            button.closedImage = UIImage(named: "plus")
            button.btnToCellMargin = 5
            return button
        }()
        view.addSubview(btnFloating)
    }
    
    private func performFakeNetworkRequest() {
        loadingPlaceholderView.cover(view)
    }

    private func finishFakeRequest() {
        spinner.stopAnimating()
        stopLoader()
        refreshControl.endRefreshing()
        loadingPlaceholderView.uncover()
    }

    private func setupLoadingPlaceholderView() {
        
        loadingPlaceholderView.gradientColor = .white
        loadingPlaceholderView.backgroundColor = .white
    }
    
    @objc func refresh(_ sender: Any) {
        getAlllCats()
      }
    
    func getAlllCats()
    {
        let params = AllCatsBody()
        params.size = "small"
        params.order = "ASC"
        params.page = 0
        params.limit = 25
        params.breedIds = breedId
        params.hasBreed = true
        
        ServerManager.getAllCats(params: params) { (status, data) in
            if status == "success"
            {
                self.arrCheckNextPageCats = data!
                Globals.arrAllCatsImages = self.arrCheckNextPageCats
                self.getFavourites()
            }
            else
            {
                self.finishFakeRequest()
                self.showAlert(message: status)
            }
        }
    }
    
    func getMoreCats(pageNumber: Int)
    {
        let params = AllCatsBody()
        params.size = "small"
        params.order = "ASC"
        params.page = pageNumber
        params.limit = 25
        params.breedIds = breedId
        params.hasBreed = true
        ServerManager.getAllCats(params: params) { (status, data) in
            
            if status == "success"
            {
                self.arrCheckNextPageCats = data!
                Globals.arrAllCatsImages.append(contentsOf: self.arrCheckNextPageCats)
                self.getFavourites()
                
            }
            else
            {
                self.showAlert(message: status)
            }
        }
    }

    func getBreeds()
    {
        let params = BreedsBody()
        params.limit = "100"
        params.page = "0"
        ServerManager.getBreeds(params: params) { (status, data) in
            
            if status == "success"
            {
                Globals.arrCatsBreeds = data
                
                //Cache data
                DataCache.instance.write(object: data!.toJSON() as NSCoding, forKey: CacheValue.breedsData)
                
                self.filter.anchorView = self.btnFilter // UIView or UIBarButtonItem
                for item in Globals.arrCatsBreeds{
                    // The list of items to display. Can be changed dynamically
                    self.filter.dataSource.append(item.name!)
                }
            }
            else
            {
                self.filter.anchorView = self.btnFilter // UIView or UIBarButtonItem
                for item in Globals.arrCatsBreeds{
                    // The list of items to display. Can be changed dynamically
                    self.filter.dataSource.append(item.name!)
                }
                self.showAlert(message: status)
            }
        }
    }
    
    func getFavourites()
    {
       // startLoader()
        let params = FavourtieBody()
        params.subId = Constants.UDID!
        ServerManager.getFavourites(params: params) { (status, data) in
            self.finishFakeRequest()
            if status == "success"
            {
                Globals.arrFavouriteCatsImages = data
                 
                for (index, element) in Globals.arrAllCatsImages.enumerated() {
                     
                    if let indexNumber = Globals.arrFavouriteCatsImages.firstIndex(where: {$0.imageId == element.id})
                    {
                        Globals.arrAllCatsImages[index].favouriteId = Globals.arrFavouriteCatsImages[indexNumber].id
                        
                        Globals.arrAllCatsImages[index].isFavourtie = true
                    }
                    else
                    {
                        Globals.arrAllCatsImages[index].isFavourtie = false
                    }
                }
                
                //Cache Data
                DataCache.instance.write(object: Globals.arrFavouriteCatsImages.toJSON() as NSCoding, forKey: CacheValue.favouriteData)
                
                DataCache.instance.write(object: Globals.arrAllCatsImages.toJSON() as NSCoding, forKey: CacheValue.allCatsData)
                
                self.tblAllCats.reloadData()
            }
            else
            {
                self.showAlert(message: status)
            }
        }
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            startLoader()
            ServerManager.uploadCatPicture(imgFile: image, subId: Constants.UDID!) { (status) in
                self.stopLoader()
                if status == "success"
                {
                    self.showAlert(message: "Image uploaded successfully.")
                }
                else
                {
                    self.showAlert(message: status)
                }
            }
        }

        self.picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- TableView DataSource
extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Globals.arrAllCatsImages == nil ? 0 : Globals.arrAllCatsImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let homeCatsTCell = tableView.dequeueReusableCell(withIdentifier: "HomeCatsTCell", for: indexPath) as! HomeCatsTCell
        
        
        homeCatsTCell.lblBreedName.text = "Breed: \(Globals.arrAllCatsImages[indexPath.row].breeds?.first?.name ?? " Not Available")"
        
        homeCatsTCell.btnFavourite.tag = indexPath.row
        
        if Globals.arrAllCatsImages[indexPath.row].isFavourtie == nil
        {
            Globals.arrAllCatsImages[indexPath.row].isFavourtie = false
            homeCatsTCell.btnFavourite.setImage(UIImage(named: "favourite"), for: .normal)
        }
        else if Globals.arrAllCatsImages[indexPath.row].isFavourtie
        {
            Globals.arrAllCatsImages[indexPath.row].isFavourtie = true
            homeCatsTCell.btnFavourite.setImage(UIImage(named: "filled heart"), for: .normal)
        }
        else
        {
            Globals.arrAllCatsImages[indexPath.row].isFavourtie = false
            homeCatsTCell.btnFavourite.setImage(UIImage(named: "favourite"), for: .normal)
        }
        
        homeCatsTCell.imgCat.image = nil
        homeCatsTCell.imgCat.sd_imageIndicator = SDWebImageActivityIndicator.large
        homeCatsTCell.imgCat.sd_setImage(with: URL(string: Globals.arrAllCatsImages[indexPath.row].url ?? ""), placeholderImage: UIImage(named: "placeholder"))
        
        return homeCatsTCell
    }
}

//MARK:- TableView Delegates
extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let catsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CatsDetailVC") as! CatsDetailVC
        catsDetailVC.index = indexPath.row
        navigationController?.pushViewController(catsDetailVC, animated: true)
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
        if indexPath.row == Globals.arrAllCatsImages.count - 1 {
            
            if arrCheckNextPageCats.count > 0
            {
                self.pageNumber += 1
                spinner = UIActivityIndicatorView(style: .medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.tblAllCats.tableFooterView = spinner
                self.tblAllCats.tableFooterView?.isHidden = false
                
                // Little delay to show activity indicator
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    //self.spinner.stopAnimating()
                    self.tblAllCats.tableFooterView = nil
                    self.tblAllCats.tableFooterView?.isHidden = true
                    self.getMoreCats(pageNumber: self.pageNumber)
                    
                }
            }
        }
    }
}

//MARK:- Floating Button Delegate
extension HomeVC: LNFloatingActionButtonDelegate {
    internal func floatingActionButton(_ floatingActionButton: LNFloatingActionButton, didSelectItemAtIndex index: Int) {
        if index == 0
        {
            openGallary()
        }
        else
        {
            openCamera()
        }
        floatingActionButton.close()
    }
}

//MARK:- Floating Button DataSource
extension HomeVC: LNFloatingActionButtonDataSource {
    func numberOfCells(_ floatingActionButton: LNFloatingActionButton) -> Int {
        return btnFloatingCells.count
    }

    func cellForIndex(_ index: Int) -> LNFloatingActionButtonCell {
        return btnFloatingCells[index]
    }
}

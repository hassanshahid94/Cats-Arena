//
//  FakeLaunchScreenVC.swift
//  CatsViewer
//
//  Created by Hassan on 20.4.2021.
//

import UIKit
import DataCache
import ObjectMapper

class FakeLaunchScreenVC: BaseVC {

    //MARK:- Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            //Load cahce data
            self.loadDefaults()
        }
    }
    
    // MARK: - Functions
    func loadDefaults() {
       if let allCatsData = DataCache.instance.readObject(forKey: CacheValue.allCatsData) {
        Globals.arrAllCatsImages = Mapper<CatsViewerAllCatsResponse>().mapArray(JSONArray: allCatsData as! [[String : Any]])
       }
        else {
         Globals.arrAllCatsImages = [CatsViewerAllCatsResponse]()
       }
        
        if let favouriteCats = DataCache.instance.readObject(forKey: CacheValue.favouriteData) {
            Globals.arrFavouriteCatsImages = Mapper<CatsViewerFavouriteResponse>().mapArray(JSONArray: favouriteCats as! [[String : Any]])
        }
        else {
            Globals.arrFavouriteCatsImages = [CatsViewerFavouriteResponse]()
        }
       if let breeds = DataCache.instance.readObject(forKey: CacheValue.breedsData) {
        Globals.arrCatsBreeds = Mapper<CatsViewerBreedsResponse>().mapArray(JSONArray: breeds as! [[String : Any]])
       }
       else {
        Globals.arrCatsBreeds = [CatsViewerBreedsResponse]()
       }
        let tabBarMainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarMainVC") as! TabBarMainVC
        navigationController?.pushViewController(tabBarMainVC, animated: true)
    }
}


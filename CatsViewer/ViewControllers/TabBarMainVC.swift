//
//  TabBarMainVC.swift
//  CatsViewer
//
//  Created by Hassan on 20.4.2021.
//

import UIKit
import SOTabBar

class TabBarMainVC: SOTabBarController {
  
    //MARK:- Load
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = UIColor.CatsViewer_tabBar_Selection
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    //MARK:- Functions
    func initView() {
        //Adding View Controllers to Tabbar
        self.delegate = self
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let favouriteVC = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        favouriteVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "favourite"), selectedImage: UIImage(named: "favourite"))
        viewControllers = [homeVC, favouriteVC]
    }
}

//MARK:- TabBarController Delegate
extension TabBarMainVC: SOTabBarControllerDelegate {
    func tabBarController(_ tabBarController: SOTabBarController, didSelect viewController: UIViewController) {
    }
}

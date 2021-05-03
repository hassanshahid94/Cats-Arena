//
//  BaseVC.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import UIKit
import RappleProgressHUD
import DataCache

class BaseVC: UIViewController {

    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func startLoader() {
        RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)
    }
    func stopLoader() {
        RappleActivityIndicatorView.stopAnimation()
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Cats Viewer", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func cleanAllCache() {
        DataCache.instance.cleanAll()
    }
}


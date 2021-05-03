//
//  ServerManager.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class ServerManager {
    
    public static func getAllCats(params: AllCatsBody, completion: @escaping (String ,[CatsViewerAllCatsResponse]?) -> Void) {
        let headers = ["x-api-key": Constants.apiKey]
        let url = "\(Constants.baseURL)\(CatsViewerEndpoints.catsSearch.rawValue)?size=\(String(describing: params.size!))&order=\(String(describing: params.order!))&page=\(String(describing: params.page!))&limit=\(String(describing: params.limit!))&has_breeds=\(String(describing: params.hasBreed!))&breed_ids=\(String(describing: params.breedIds!))"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        Alamofire.request(request).responseArray { (response: DataResponse<[CatsViewerAllCatsResponse]>) in
            switch response.result {
            case .success:
                let forecastArray = response.result.value
                completion("success",forecastArray)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
        }
    }
    public static func getBreeds(params: BreedsBody, completion: @escaping (String ,[CatsViewerBreedsResponse]?) -> Void) {
        let headers = ["x-api-key": Constants.apiKey]
        let url = "\(Constants.baseURL)\(CatsViewerEndpoints.getBreeds.rawValue)limit=\(params.limit!)&page=\(params.page!)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        Alamofire.request(request).responseArray { (response: DataResponse<[CatsViewerBreedsResponse]>) in
            switch response.result {
                case .success:
                    let forecastArray = response.result.value
                    completion("success",forecastArray)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
        }
    }
    public static func getFavourites(params: FavourtieBody, completion: @escaping (String ,[CatsViewerFavouriteResponse]?) -> Void) {
        let headers = ["x-api-key": Constants.apiKey]
         let url = "\(Constants.baseURL)\(CatsViewerEndpoints.getFavourites.rawValue)sub_id=\(params.subId!)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        Alamofire.request(request).responseArray { (response: DataResponse<[CatsViewerFavouriteResponse]>) in
            switch response.result
            {
            case .success:
                let forecastArray = response.result.value
                completion("success",forecastArray)
            case .failure(let error):
                completion(error.localizedDescription, nil)
            }
        }
    }
    public static func addFavourite(params: AddFavouriteBody, completion: @escaping (String, CatsViewerFavouriteResponse?) -> Void) {
        let headers = ["x-api-key": Constants.apiKey]
        let url = "\(Constants.baseURL)\(CatsViewerEndpoints.addFavourtie.rawValue)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: params.toJSON(), options: [])
        Alamofire.request(request).responseObject{ (response: DataResponse<CatsViewerFavouriteResponse>) in
            switch response.result {
            case .success:
                let object = response.result.value
                completion("success",object)
            case .failure(let error):
                completion(error.localizedDescription, nil)
            }
        }
    }
    public static  func deleteFavourite(params: DeleteFavouriteBody, completion: @escaping (String) -> Void)
    {
        let headers = ["x-api-key": Constants.apiKey]
        let url = "\(Constants.baseURL)\(CatsViewerEndpoints.addFavourtie.rawValue)\(String(describing: params.favouriteId ?? 0))"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        Alamofire.request(request).responseObject{ (response: DataResponse<CatsViewerFavouriteResponse>) in
            switch response.result {
            case .success:
                //let object = response.result.value
                completion("success")
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    public static func uploadCatPicture(imgFile: UIImage, subId: String, completion: @escaping (String) -> Void)
    {
        let url = "\(Constants.baseURL)\(CatsViewerEndpoints.addCatPicture.rawValue)"
        let headers = ["Content-Type": "application/json","x-api-key": Constants.apiKey]
        let imgData = imgFile.jpegData(compressionQuality: 0.2)!
        let parameters = ["sub_id": subId] //Optional for extra parameter
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
        to:url, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                   // completion("success")
                })
                upload.responseJSON { response in
                    if let result = response.result.value {
                        let jdict = result as! NSDictionary
                        let error = jdict["message"]
                        completion(error  as? String ?? "success")
                    }
                    else {
                        completion("Something went wrong. Please try again.")
                    }
                }
            case .failure(let encodingError):
                completion("Something went wrong. Please try again.")
            }
        }
    }
}

enum CatsViewerEndpoints: String {
    //Rest API URL
    case catsSearch              = "v1/images/search?"
    case getBreeds               = "v1/breeds?"
    case getFavourites           = "v1/favourites?"
    case addFavourtie            = "v1/favourites/"
    case addCatPicture           = "v1/images/upload"
}

//
//  CatsViewerTests.swift
//  CatsViewerTests
//
//  Created by Hassan on 18.4.2021.
//

import XCTest
import ObjectMapper

@testable import CatsViewer

class CatsViewerTests: XCTestCase {
    
    //MARK:- UnitTest Cases
    func testGetAllCats() {
        let data = readData(fileName: "AllCatsResponse")
        var expected: [CatsViewerAllCatsResponse]!        
        expected = Mapper<CatsViewerAllCatsResponse>().mapArray(JSONArray: data as! [[String : Any]])
        let expectatio = expectation(description: "GET \(Constants.baseURL)\(CatsViewerEndpoints.catsSearch.rawValue)")
        let params = AllCatsBody()
        params.size = "small"
        params.order = "ASC"
        params.page = 0
        params.limit = 25
        params.hasBreed = true
        params.breedIds = ""
        ServerManager.getAllCats(params: params) { (status, data) in
            XCTAssertEqual(expected.count, data?.count)
            expectatio.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            print ("\(String(describing: error?.localizedDescription))")
        }
    }
    func testGetBreeds() {
        let data = readData(fileName: "CatsBreeds")
        var expected: [CatsViewerBreedsResponse]!
        expected = Mapper<CatsViewerBreedsResponse>().mapArray(JSONArray: data as! [[String : Any]])
        let expectatio = expectation(description: "GET \(Constants.baseURL)\(CatsViewerEndpoints.getBreeds.rawValue)")
        let params = BreedsBody()
        params.limit = "100"
        params.page = "0"
        ServerManager.getBreeds(params: params) { (status, data) in
            XCTAssertEqual(expected.count, data?.count)
            expectatio.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            print ("\(String(describing: error?.localizedDescription))")
        }
    }
    //Reading Json File response
    func readData(fileName: String) -> NSArray? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? NSArray {
                    return jsonResult
                }
            }
            catch {
                // handle error
            }
        }
        return nil
    }
}

//
//  WiproCodingTestTests.swift
//  WiproCodingTestTests
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import XCTest
@testable import WiproCodingTest

class WiproCodingTestTests: XCTestCase {
    var rootWindow: UIWindow!
    var canadaData: CanadaDataModel?
    var tableViewController :CanadaListViewController!
    override func setUp() {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        tableViewController = CanadaListViewController()
        let navigationController = UINavigationController(rootViewController: tableViewController)
        rootWindow?.rootViewController = navigationController
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK:- Test Canada Service Request Success or Not
    func testNetworkCallSuccessRequest() {
        let result = expectation(description: "Service Request is correct")
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", type: CanadaDataModel.self, completionHandler: { (responseData) in
            self.canadaData = responseData as? CanadaDataModel
            XCTAssertNotNil(self.canadaData, "Data as expected")
            result.fulfill()
        }) { (errorObject) in
            XCTFail("Error while fetching data")
        }
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
        
    }
    
    //MARK:- Test Canada TableView with Actual 6 records
    func testCanadaTableViewWithActualData() {
        var canadaRowsList = [Rows]()
        let result = expectation(description: "Canada data")
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", type: CanadaDataModel.self, completionHandler: { (responseData) in
            self.canadaData = responseData as? CanadaDataModel
            for index in 0...5 {
                let eachRow = self.canadaData?.rows![index]
                canadaRowsList.append(eachRow!)
            }
            self.tableViewController.canadaInfoList = canadaRowsList
            DispatchQueue.main.async {
                self.tableViewController.tableView.reloadData()
                let cells = self.tableViewController.tableView.visibleCells as! [CanadaListCell]
                XCTAssertEqual(cells.count, canadaRowsList.count, "Here cell count should match visible cells count")
                for (index, element) in cells.enumerated() {
                    XCTAssertEqual(element.titleLabel.text, (canadaRowsList[index].title != nil) ? canadaRowsList[index].title : "No Title" , "Here canada row title should match")
                    XCTAssertEqual(element.descriptionLabel.text, (canadaRowsList[index].description != nil) ? canadaRowsList[index].description : "No Description", "Here canada row description should match")
                }
                XCTAssertNotNil("Data as expected")
                result.fulfill()
            }
        }) { (errorObject) in
            XCTFail("Error while fetching data")
        }
        waitForExpectations(timeout: 12.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
    }
    
    //MARK:- Test Canada TableView Title Matches or Not
    func testCanadaDataTitleValidation() {
        let result = expectation(description: "Canada Title Check Success")
        let expectedTitle = "About Canada"
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", type: CanadaDataModel.self, completionHandler: { (responseData) in
            self.canadaData = responseData as? CanadaDataModel
            let titleString = (self.canadaData?.title != nil) ? self.canadaData?.title : ""
            XCTAssertEqual(titleString, expectedTitle)
            XCTAssertNotNil(self.canadaData, "Canada data found")
            result.fulfill()
        }) { (errorObject) in
            XCTFail("Error while fetching data")
        }
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
    }
    
    //MARK:- Test Canada Row Model
    func testCanadaRowsModel() {
        var canadaRowsList = [Rows]()
        let eachRow = Rows.init(title: "title1", description: "description1", imageHref: "imageUrl1")
        canadaRowsList.append(eachRow)
        XCTAssertEqual(canadaRowsList[0].title, eachRow.title)
    }
    
    //MARK:- Test TableView
    func testHasATableView() {
        XCTAssertNotNil(self.tableViewController.tableView)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(self.tableViewController.tableView.dataSource)
    }
    
    func testTableViewCellHasReuseIdentifier() {
        self.tableViewController.canadaInfoList = [Rows.init(title: "title1", description: "description1", imageHref: "imageUrl1")]
        let cell = self.tableViewController.tableView(self.tableViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CanadaListCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "canadaCellId"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}

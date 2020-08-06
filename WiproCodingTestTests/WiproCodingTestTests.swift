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
    
    var rootWindow: UIWindow?
    var canadaData: CanadaDataModel?
    var tableViewController :CanadaListViewController!
    
    override func setUp() {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        tableViewController = CanadaListViewController()
        let navigationController = CustomNavigationController(rootViewController: tableViewController)
        rootWindow?.rootViewController = navigationController
        //load view hierarchy
        _ = tableViewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Test Canada Service Request Success or Not
    func testNetworkCallSuccessRequest() {
        let result = expectation(description: "Service Request is correct")
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: AppUrls.baseUrl, type: CanadaDataModel.self, completionHandler: { (responseData) in
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
    
    // MARK: - Test Canada Bad Service Request
    func testBadNetworkCallRequest() {
        let result = expectation(description: "Bad Service Request")
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: "//dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", type: CanadaDataModel.self, completionHandler: { (responseData) in
            self.canadaData = responseData as? CanadaDataModel
            XCTAssertNotNil(self.canadaData, "Data as expected")
        }) { (errorObject) in
            //bad request
            result.fulfill()
        }
        waitForExpectations(timeout: 12.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
    }
    
    // MARK: - Test Canada TableView with Actual 6 records
    func testCanadaTableViewWithActualData() {
        var canadaRowsList = [Rows]()
        let result = expectation(description: "Canada data")
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: AppUrls.baseUrl, type: CanadaDataModel.self, completionHandler: { (responseData) in
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
    
    // MARK: - Test Navigation Title Exists or Not
    func testNavigationTitleView() {
        XCTAssertNotNil(self.tableViewController.title)
    }
    
    // MARK: - Test Canada TableView Navigation Title Matches or Not
    func testNavigationTitleValidation() {
        let result = expectation(description: "Navigation Title Exists")
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: AppUrls.baseUrl, type: CanadaDataModel.self, completionHandler: { (responseData) in
            self.canadaData = responseData as? CanadaDataModel
            let titleString = (self.canadaData?.title != nil) ? self.canadaData?.title : ""
            DispatchQueue.main.async {
                let navigationTitle = self.tableViewController.navigationController?.title
                XCTAssertEqual(titleString, navigationTitle)
                result.fulfill()
            }
            XCTAssertNotNil(self.canadaData, "Canada data found")
        }) { (errorObject) in
            XCTFail("Error while fetching data")
        }
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
    }
    
    // MARK: - Test Canada Row Model
    func testCanadaRowsModel() {
        var canadaRowsList = [Rows]()
        let eachRow = Rows.init(title: "title1", description: "description1", imageHref: "imageUrl1")
        canadaRowsList.append(eachRow)
        XCTAssertEqual(canadaRowsList[0].title, eachRow.title)
    }
    
    // MARK: - Test Positive Canada Model
    func testPositiveCanadaModel() {
        let eachRow = Rows.init(title: "title1", description: "description1", imageHref: "imageUrl1")
        let canadaModel = CanadaDataModel(title: AppConstants.canadaNavigationTitle, rows: [eachRow])
        XCTAssertEqual(canadaModel.title, "About Canada")
        XCTAssertEqual(canadaModel.rows![0].title, "title1")
        XCTAssertEqual(canadaModel.rows![0].description, "description1")
    }
    
    // MARK: - Test Negative Canada Model
    func testNegativeCanadaModel() {
        let eachRow = Rows.init(title: nil, description: nil, imageHref: nil)
        let canadaModel = CanadaDataModel(title: nil, rows: [eachRow])
        XCTAssertNotEqual(canadaModel.title, "About Canada")
        XCTAssertNotEqual(canadaModel.rows![0].title, "title1")
        XCTAssertNotEqual(canadaModel.rows![0].description, "title1")
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
        let expectedReuseIdentifier = AppConstants.cellIdentifier
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    // MARK: - Test alertController
    func testAlertController() {
        CustomAlert.showAlertViewWith(title: Alerts.title, message: "Test Alert Controller")
        let expectation = XCTestExpectation(description: "Test Alert")
        DispatchQueue.main.async {
            XCTAssertTrue(UIWindow.key?.rootViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }
    
    // MARK: - Test Activity Indicator
    func testActivityIndicatorView() {
        ActivityIndicator.showActivityIndicator()
        let expectation = XCTestExpectation(description: "Test Activity Indicator")
        DispatchQueue.main.async {
            let topView = UIWindow.key?.rootViewController?.view
            for subview in topView!.subviews as [UIView] {
                if subview is UIActivityIndicatorView {
                    XCTAssertTrue(true)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }
}

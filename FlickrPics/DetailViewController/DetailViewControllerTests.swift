//
//  DetailViewControllerTests.swift
//  FlickrPicsTests
//
//  Created by Benjohn on 05/06/2019.
//  Copyright © 2019 Russell Toon. All rights reserved.
//

import XCTest

@testable import FlickrPics

class DetailViewControllerTests: XCTestCase {

    func test_canCreateViewController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail")
        XCTAssertNotNil(viewController)
    }
    
    func test_createdVCHasView() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail")
        XCTAssertNotNil(viewController.view)
    }
}

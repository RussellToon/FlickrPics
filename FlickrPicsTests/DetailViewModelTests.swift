//
//  DetailViewModelTests.swift
//  FlickrPicsTests
//
//  Created by Candidate One on 05/06/2019.
//

import XCTest

@testable import FlickrPics

class DetailViewModelTests: XCTestCase {

    override func setUp() {
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

    struct ImageFetcherMock: ImageFetcherProtocol {

        var downloadImageResponse: ImageResponse?
        func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler) {
            completionHandler(downloadImageResponse!)
        }
    }
}

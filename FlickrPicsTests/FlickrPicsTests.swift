//
//  Copyright © 2019 News UK. All rights reserved.
//

import XCTest
@testable import FlickrPics

class FlickrPicsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {

        let expectation = XCTestExpectation(description: "Correct result returned")

        let fetcher = RecentsFetcher()

        fetcher.fetchRecents(withCompletion: { (response) in

            print("Response:\n\(response)")

            guard case .Recents(let recents) = response else {
                XCTFail()
                return
            }
            XCTAssert(recents.count == 100)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 10.0)
    }

}

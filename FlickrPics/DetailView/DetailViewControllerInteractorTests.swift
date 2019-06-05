//
//  DetailViewControllerInteractorTests.swift
//  FlickrPicsTests
//
//  Created by Benjohn on 05/06/2019.
//  Copyright © 2019 Russell Toon. All rights reserved.
//

import XCTest

@testable import FlickrPics

class DetailViewControllerInteractorTests: XCTestCase {

    let testPhoto = Photo(id: "id", title: "title", thumbnailUrl: "thumnail", fullSizeUrl: "fullsize")
    let testImage = UIImage()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewDidLoad_setsMessageToPhotoTitle() {
        
        let mockFetcher = successfulFetcher()
        let mockDetailView = MockDetailViewController()
        let sut = DetailViewControllerInteractor(photo: testPhoto, detailViewController: mockDetailView, fetcher: mockFetcher)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(mockDetailView.model?.message, testPhoto.title)
    }

    func test_viewDidLoad_invokesImageFetchWithFullSizeURL() {
    }
    
    func test_viewDidLoad_successfulImageFetchCompletion_setsImage() {
    }
}

//MARK:-

private extension DetailViewControllerInteractorTests {
    
    func successfulFetcher() -> MockImageFetcher {
        return MockImageFetcher(response: .Success(image: testImage))
    }
    
    func failingFetcher(error: ImageFetchError = .FailedToRetrieveImage) -> MockImageFetcher {
        return MockImageFetcher(response: .Failure(error: error))
    }
}



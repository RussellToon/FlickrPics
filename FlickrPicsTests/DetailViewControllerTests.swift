//
//  DetailViewControllerTests.swift
//  FlickrPicsTests
//
//  Created by Candidate Two on 05/06/2019.
//

import XCTest
@testable import FlickrPics

class DetailViewControllerTests: XCTestCase {

    var viewController: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let rawVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        viewController = rawVC as? DetailViewController
        viewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_canInitializeViewController_views() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.detailDescriptionLabel)
        XCTAssertNotNil(viewController.imageView)
    }
    
    func test_setsDescriptionLabel_toItemTitle_whenSet() {
        XCTAssertNil(viewController.detailDescriptionLabel.text)
        let mockPhoto = Photo.Builder().build()
        viewController.detailItem = mockPhoto
        XCTAssertEqual(viewController.detailDescriptionLabel.text, "Some Title")
    }
    
    func test_setsDescriptionLabel_toItemTitle_whenSet_2() {
        XCTAssertNil(viewController.detailDescriptionLabel.text)
        var builder = Photo.Builder()
        builder.with(title: "Some Other Title")
        let mockPhoto = builder.build()
        viewController.detailItem = mockPhoto
        XCTAssertEqual(viewController.detailDescriptionLabel.text, "Some Other Title")
    }
    
    func test_hasDefaultImageFetcher_toStart() {
        XCTAssertNotNil(viewController.imageFetcher as? DefaultImageFetcher)
    }
    
    func test_startsDownload_ofFullSizePhoto_whenItemIsSet() {
        let mockImageFetcher = MockImageFetcher()
        XCTAssertEqual(mockImageFetcher.recordedInvocations.downloadImage.count, 0)
        viewController.imageFetcher = mockImageFetcher
        viewController.detailItem = Photo.Builder().build()
        XCTAssertEqual(mockImageFetcher.recordedInvocations.downloadImage.count, 1)
        let tuple = mockImageFetcher.recordedInvocations.downloadImage.first
        XCTAssertEqual(tuple?.url, URL(string: "http://www.example.com/fullSizeUrl.png"))
    }
    
    func test_showsErrorMessage_ifDownloadOfPhoto_fails() {
        let mockImageFetcher = MockImageFetcher()
        viewController.imageFetcher = mockImageFetcher
        viewController.detailItem = Photo.Builder().build()
        let tuple = mockImageFetcher.recordedInvocations.downloadImage.first
        tuple?.completion(.Failure(error: .FailedToDecodeImageFormat))
        XCTAssertEqual(viewController.detailDescriptionLabel.text, "An error has occurred")
    }
    
    func test_showsImage_ifDownloadOfPhoto_succeeds() {
        let image = UIImage()
        let mockImageFetcher = MockImageFetcher()
        viewController.imageFetcher = mockImageFetcher
        viewController.detailItem = Photo.Builder().build()
        let tuple = mockImageFetcher.recordedInvocations.downloadImage.first
        tuple?.completion(.Success(image: image))
        XCTAssertTrue(viewController.imageView.image === image)
    }

}

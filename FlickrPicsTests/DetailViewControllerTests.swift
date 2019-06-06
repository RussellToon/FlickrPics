//
//  DetailViewControllerTests.swift
//  FlickrPicsTests
//
//  Created by Candidate Three on 05/06/2019.
//

import XCTest

@testable import FlickrPics

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    var mockImageFetcher: MockimageFetcher!

    override func setUp() {
        super.setUp()
        mockImageFetcher = MockimageFetcher()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewControllerID") as! DetailViewController
        sut.imageFetcher = mockImageFetcher
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        mockImageFetcher = nil
        super.tearDown()
    }

    var testDetailItem: Photo {
        return Photo(id: "1", title: "Title", thumbnailUrl: "http://.com", fullSizeUrl: "http://full.com")
    }

}

extension DetailViewControllerTests {

    func test_DetailViewController_HasLabelAndImageView() {
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.detailDescriptionLabel)
    }

    func test_set_detailItem_ConfiguresLabelWithText() {
        sut.detailItem = testDetailItem
        XCTAssertEqual(sut.detailDescriptionLabel.text, "Title")
    }

    func test_set_detailItem_InitiatesDownload() {
        sut.detailItem = testDetailItem
        XCTAssertEqual(mockImageFetcher.downloadImageURLCalled, URL(string: "http://full.com"))
    }

    func test_set_detailItem_SetsDownloadedImageToImageView() {
        let testImage = UIImage()
        mockImageFetcher.response = .Success(image: testImage)
        sut.detailItem = testDetailItem
        XCTAssertEqual(testImage, sut.imageView.image)
    }

    func test_set_detailItem_DownloadFailed_ShowsErrorImageInImageView() {

        mockImageFetcher.response = .Failure(error: .FailedToRetrieveImage)
        let failedDownloadImage = UIImage(named: "failedDowload")
        sut.detailItem = testDetailItem
        XCTAssertNotNil(sut.imageView.image)
        XCTAssertEqual(failedDownloadImage, sut.imageView.image)
    }
}

final class MockimageFetcher: ImageFetching {

    var downloadImageURLCalled:URL?
    var response: ImageResponse?

    func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler) {
        downloadImageURLCalled = url
        guard let response = response else { return }
        completionHandler(response)
    }
}

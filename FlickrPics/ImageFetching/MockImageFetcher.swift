//
//  MockImageFetcher.swift
//  FlickrPics
//
//  Created by Benjohn on 05/06/2019.
//  Copyright © 2019 Russell Toon. All rights reserved.
//

import Foundation
@testable import FlickrPics

class MockImageFetcher: ImageFetching {
    
    init(response: ImageFetchResponse) {
        self.response = response
    }
    
    func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler) {
        fetchedURL = url
        completionHandler(response)
    }
    
    var fetchedURL: URL?
    let response: ImageFetchResponse
}

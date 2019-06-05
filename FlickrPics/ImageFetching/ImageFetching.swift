//
//  ImageFetching.swift
//  FlickrPics
//
//  Created by Benjohn on 05/06/2019.
//  Copyright © 2019 Russell Toon. All rights reserved.
//

import Foundation
import UIKit

protocol ImageFetching {
    
    func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler)
    typealias ImageResponseHandler = (ImageFetchResponse) -> Void
}

enum ImageFetchResponse {
    case Success(image: UIImage)
    case Failure(error: ImageFetchError)
}

enum ImageFetchError: Error {
    case FailedToRetrieveImage
    case FailedToDecodeImageFormat
}


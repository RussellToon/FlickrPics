//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

public typealias ImageResponseHandler = (ImageResponse) -> Void

public enum ImageResponse {
    case Success(image: UIImage)
    case Failure(error: ImageFetchError)
}

public enum ImageFetchError: Error {
    case FailedToRetrieveImage
    case FailedToDecodeImageFormat
}

protocol ImageFetching {
     func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler)
}

struct ImageFetcher: ImageFetching {

    func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(ImageResponse.Failure(error: .FailedToRetrieveImage))
                return
            }
            DispatchQueue.main.async() {
                guard let image = UIImage(data: data) else {
                    completionHandler(ImageResponse.Failure(error: .FailedToDecodeImageFormat))
                    return
                }
                completionHandler(ImageResponse.Success(image: image))
            }
        }
    }

    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}

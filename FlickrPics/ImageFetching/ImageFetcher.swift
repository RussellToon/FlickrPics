//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

struct ImageFetcher: ImageFetching {

    func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler) {

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(ImageFetchResponse.Failure(error: .FailedToRetrieveImage))
                return
            }
            DispatchQueue.main.async() {
                guard let image = UIImage(data: data) else {
                    completionHandler(ImageFetchResponse.Failure(error: .FailedToDecodeImageFormat))
                    return
                }
                completionHandler(ImageFetchResponse.Success(image: image))
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

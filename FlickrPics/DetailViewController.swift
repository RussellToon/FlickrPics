//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    let imageFetcher = ImageFetcher()

    func configureView() {

        if let photo = detailItem {
            if let label = detailDescriptionLabel {
                label.text = photo.title
                guard let url = URL(string: photo.fullSizeUrl) else {
                    return
                }
                imageFetcher.downloadImage(from: url) { [weak imageView] (response) in
                    guard case .Success(let image) = response else { return }
                    imageView?.image = image
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    var detailItem: Photo? {
        didSet {
            configureView()
        }
    }

}

struct ImageFetcher {

    public enum ImageResponse {
        case Success(image: UIImage)
        case Failure(error: ImageFetchError)
    }

    public enum ImageFetchError: Error {
        case FailedToRetrieveImage
        case FailedToDecodeImageFormat
    }

    public typealias ImageResponseHandler = (ImageResponse) -> Void

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

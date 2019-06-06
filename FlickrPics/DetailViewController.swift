//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var imageFetcher: ImageFetching!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var detailItem: Photo? {
        didSet {
            configureView()
        }
    }

    func configureView() {

        if let photo = detailItem {
            if let label = detailDescriptionLabel {
                label.text = photo.title
                guard let url = URL(string: photo.fullSizeUrl) else {
                    return
                }
                imageFetcher.downloadImage(from: url) { [weak imageView] (response) in

                    switch response {
                    case .Success(let image):
                        imageView?.image = image
                    case .Failure(let error) where error == .FailedToRetrieveImage:
                            imageView?.image = UIImage(named: "failedDowload")
                    case .Failure(let error) where error == .FailedToDecodeImageFormat:
                            break
                    default:
                        break
                        }
                    }

                }
            }
        }
    }

}


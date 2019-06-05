//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var imageFetcher: ImageFetching = ImageFetcher()

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
                label.text = "\(photo.id) – \(photo.title.uppercased())"
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

}


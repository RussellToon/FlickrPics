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
                imageFetcher.downloadImage(from: url, for: imageView)
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

    func downloadImage(from url: URL, for imageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}

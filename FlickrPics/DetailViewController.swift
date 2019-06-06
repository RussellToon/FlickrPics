//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    lazy var imageFetcher: ImageFetcher = DefaultImageFetcher()


    override func viewDidLoad() {
        super.viewDidLoad()
        resetView()
        configureView()
    }

    var detailItem: Photo? {
        didSet {
            configureView()
        }
    }

    private func resetView() {
        detailDescriptionLabel.text = nil
    }
    
    func configureView() {

        if let photo = detailItem {
            if let label = detailDescriptionLabel {
                label.text = photo.title
                guard let url = URL(string: photo.fullSizeUrl) else {
                    return
                }
                imageFetcher.downloadImage(from: url) { [weak self] (response) in
                    guard let self = self else { return }
                    switch response {
                        case .Success(let image):
                            self.imageView?.image = image
                        
                        case .Failure(_):
                            self.detailDescriptionLabel.text = "An error has occurred"
                    }
                    
                }
            }
        }
    }

}

//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

protocol DetailViewControllerType: class {
    func setModel(_ : DetailViewControllerModel)
}

struct DetailViewControllerModel {
    
    init(message: String?, image: UIImage?) {
        self.message = message
        self.image = image
    }
    
    let message: String?
    let image: UIImage?
}

protocol DetailViewControllerEvents {
    func viewDidLoad()
}

class DetailViewController: UIViewController, DetailViewControllerType {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var eventHandler: DetailViewControllerEvents?

    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.viewDidLoad()
    }

    func setModel(_ model: DetailViewControllerModel) {
        detailDescriptionLabel.text = model.message
        imageView.image = model.image
    }
}


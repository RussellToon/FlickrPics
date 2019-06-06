//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var viewModel: DetailViewProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        detailDescriptionLabel.text = viewModel.title
        viewModel.getImage(withCompletion: { [weak self] image in
            self?.imageView.image = image
        })
    }
}


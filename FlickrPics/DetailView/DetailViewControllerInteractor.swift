//
//  Copyright © 2019 Russell Toon. All rights reserved.
//

import Foundation

struct DetailViewControllerInteractor: DetailViewControllerEvents {

    init(photo: Photo, detailViewController: DetailViewControllerType, fetcher: ImageFetching = ImageFetcher()) {
        self.photo = photo
        self.detailView = detailViewController
        self.fetcher = fetcher
    }
    
    let photo: Photo
    let fetcher: ImageFetching
    weak var detailView: DetailViewControllerType?

    
    func viewDidLoad() {

        guard let detailView = detailView else { return }
        let model = DetailViewControllerModel(message: "hello", image: nil)
        detailView.setModel(model)
    }
}

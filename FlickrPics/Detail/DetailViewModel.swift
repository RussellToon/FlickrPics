//
//  DetailViewPresenter.swift
//  FlickrPics
//
//  Created by Candidate One on 05/06/2019.
//
import Foundation
import UIKit

protocol DetailViewProtocol {
    var title: String { get }
    func getImage(withCompletion completionHandler: @escaping (UIImage) -> Void)
}

struct DetailViewModel: DetailViewProtocol {

    private let imageFetcher: ImageFetcherProtocol
    private let photo: Photo

    init(imageFetcher: ImageFetcherProtocol, photo: Photo) {
        self.imageFetcher = imageFetcher
        self.photo = photo
    }

    var title: String {
        return self.photo.title
    }

    func getImage(withCompletion completionHandler: @escaping (UIImage) -> Void) {
        guard let url = URL(string: photo.fullSizeUrl) else {
            return
        }
        imageFetcher.downloadImage(from: url) { (response) in
            guard case .Success(let image) = response else {
                return
            }
            completionHandler(image)
        }
    }
}

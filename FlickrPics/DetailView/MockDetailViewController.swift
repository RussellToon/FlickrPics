//
//  MockDetailViewController.swift
//  FlickrPics
//
//  Created by Benjohn on 05/06/2019.
//  Copyright © 2019 Russell Toon. All rights reserved.
//

import Foundation
@testable import FlickrPics

class MockDetailViewController: DetailViewControllerType {
    func setModel(_ model: DetailViewControllerModel) {
        self.model = model
    }    
    
    var model: DetailViewControllerModel? = nil
}

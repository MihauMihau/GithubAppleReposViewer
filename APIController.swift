//
//  APIController.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 16.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import Foundation

class APIController {

    static let sharedInstance = APIController()
    var repo : ReposQueries!
    
    fileprivate init() {
        repo = ReposQueries()
    }
}

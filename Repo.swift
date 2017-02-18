//
//  repoModel.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 16.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit

class Repo: NSObject {

    var name : String!
    var fullName : String!
    var ID : Int!
    var avatar : String!
    
    var language : String?
    var watchers : Int!
    var branch : String?
    var homepage: String?
}

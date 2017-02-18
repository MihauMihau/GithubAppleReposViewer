//
//  reposQueries.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 16.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit
import Alamofire

class ReposQueries: APIBase {

    func getReposList(_ url: String, completion: @escaping (_ success:Bool, _ repos: [Repo], _ error_msg: String?) -> Void) {
        Alamofire.request(url, method: .get).responseJSON { response in
            if self.isInternetAvailable() {
                if response.result.isSuccess {
                    print(response.result.value)
                    if let a = response.result.value as? [[String: AnyObject]] {
                        if !self.isStatusValid(response.response?.statusCode, url: url) {
                            return completion(false, [], "Server communication error")
                        }
                        var repos = [Repo]()
                        for e in a {
                            let repo = Repo()
                            guard let id = e["id"] as? NSNumber else {
                                continue
                            }
                            repo.ID = id.intValue
                            if let name = e["name"] as? String {
                                repo.name = name
                            }
                            if let fullName = e["full_name"] as? String {
                                repo.fullName = fullName
                            }
                            if let avatar = e["owner"]?["avatar_url"] as? String {
                                repo.avatar = avatar
                            }
                            if let laguage = e["language"] as? String {
                                repo.language = laguage
                            }
                            if let watchers = e["watchers"] as? Int {
                                repo.watchers = watchers
                            }
                            if let branch = e["default_branch"] as? String {
                                repo.branch = branch
                            }
                            if let homepage = e["homepage"] as? String {
                                repo.homepage = homepage
                            }
                            repos.append(repo)
                        }
                        return completion(true, repos, nil)
                    }
                }
            }
            return completion(false, [], "Server communication error")
        }
    }
}

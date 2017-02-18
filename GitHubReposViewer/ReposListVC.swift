//
//  ViewController.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 16.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit
import PKHUD
import Kingfisher

class ReposListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    var repos = [Repo]()
    var segueRepoDetails = "repoDetails"
    var refreshControl : UIRefreshControl!
    var selectedRepo : Repo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTheView()
        initializeRepoList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.backgroundColor = Const.backgoundColor
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "repoCell") as! RepoListCell
        let repo = repos[indexPath.row]
        cell.nameLabel.text = repo.name
        cell.fullNameLabel.text = repo.fullName
        cell.idLabel.text = String(repo.ID)
        DispatchQueue.global(qos: .userInteractive).async {
            let imageUrl = URL(string: repo.avatar!)
            DispatchQueue.main.async {
                cell.avatarImage.kf.setImage(with: imageUrl)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRepo = repos[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: segueRepoDetails, sender: nil)
    }
    
    func getReposList(_ completion: @escaping (_ success: Bool) -> Void) {
        HUD.show(.progress)
        APIController.sharedInstance.repo.getReposList(Const.apiURL, completion: { (success, repo, error_msg) in
            if success {
                self.repos.append(contentsOf: repo)
                self.tableView.reloadData()
                HUD.flash(.labeledSuccess(title: "Success!", subtitle: ""), delay: 0.5)
                return completion(true)
            } else {
                HUD.flash(.labeledError(title: "Connection error", subtitle: "Could not connect to server"), delay: 4.0)
                return completion(false)
            }
        })
    }
    
    func initializeRepoList() {
        repos.removeAll()
        tableView.reloadData()
        getReposList() { (success) in
            DispatchQueue.main.async(execute: {
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    func initializeTheView() {
        tableView.dataSource = self
        tableView.delegate = self
        initializeRefreshControl()
        navigationItem.title = "GitHub Apple's Repos"
    }
    
    func initializeRefreshControl() {
        refreshControl = UIRefreshControl()
        let attributes = [NSForegroundColorAttributeName: Const.navigationBarColor]
        let attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: #selector(ReposListVC.initializeRepoList), for: UIControlEvents.valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = Const.navigationBarColor
        tableView.addSubview(refreshControl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        super.prepare(for: segue, sender: sender)
        switch segue.identifier! {
        case segueRepoDetails:
            let destViewController = segue.destination as! RepoDetailsVC
            destViewController.chosenRepo = selectedRepo
        default:
        break
        }
    }
}

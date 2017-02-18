//
//  RepoDetails.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 17.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit
import Kingfisher

class RepoDetailsVC: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var chosenRepo : Repo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTheView()
    }
    
    func initializeTheView() {
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        navigationItem.title = "Repo's details"
        shadowView.addShadowToView()
        setInfo()
    }
    
    func setInfo() {
        nameLabel.text = chosenRepo.name
        let imageUrl = URL(string: chosenRepo.avatar!)
        avatar.kf.setImage(with: imageUrl)
        languageLabel.text = chosenRepo.language
        watchersLabel.text = String(describing: chosenRepo.watchers!) + " watchers"
        branchLabel.text = "Branch: " + chosenRepo.branch!
        setHomepageInfo()
    }
    
    func setHomepageInfo() {
        if chosenRepo.homepage == "" || chosenRepo.homepage == nil {
            homepageLabel.isHidden = false
            homepageButton.isHidden = true
            homepageLabel.text = "No homepage!"
        } else {
            homepageLabel.isHidden = true
            homepageButton.isHidden = false
            homepageButton.setTitle(chosenRepo.homepage, for: .normal)
        }
    }
    
    @IBAction func homepageButtonTapped(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: (homepageButton.titleLabel?.text)!)!)
    }
}

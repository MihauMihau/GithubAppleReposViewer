//
//  repoListCell.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 16.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit

class RepoListCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.addShadowToView()
    }
}

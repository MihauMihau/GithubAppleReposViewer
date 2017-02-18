//
//  Extension.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 16.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit

public extension UIView {
    
    func addShadowToView() {
        self.layer.masksToBounds =  false
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

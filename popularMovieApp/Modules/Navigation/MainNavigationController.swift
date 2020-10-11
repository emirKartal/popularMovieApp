//
//  MainNavigationController.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = .white
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = .black
        
        // Delete Back button title
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
    }

}

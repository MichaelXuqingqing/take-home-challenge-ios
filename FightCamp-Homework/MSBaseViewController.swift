//
//  MSBaseViewController.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/19.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

import UIKit

/**
 * A public view controller for setting public properties and adding common methods
 */
class MSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.secondaryBackground
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
}

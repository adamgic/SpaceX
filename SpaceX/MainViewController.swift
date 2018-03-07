//
//  MainViewController.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var contentViewController: ContentViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contentViewController = segue.destination as? ContentViewController {
            self.contentViewController = contentViewController
        }
    }

    @IBAction func successValueChanged(_ sender: UISwitch) {
        contentViewController?.showSuccess = sender.isOn
    }

    @IBAction func failureValueChanged(_ sender: UISwitch) {
        contentViewController?.showFailure = sender.isOn
    }
}


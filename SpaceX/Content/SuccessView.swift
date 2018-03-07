//
//  SuccessView.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import UIKit

class SuccessView: UIView {

    enum MissonResult {
        case success, failure

        var color: UIColor {
            switch self {
            case .success:
                return UIColor(red: 0, green: 0.6, blue: 0.2, alpha: 1)
            case .failure:
                return .red
            }
        }
    }

    var result: MissonResult = .success {
        didSet {
            backgroundColor = result.color
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.width / 2
    }
}

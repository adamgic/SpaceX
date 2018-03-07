//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {

    @IBOutlet weak var missionPatchView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var successView: SuccessView!

    var imageDataTask: URLSessionDataTask?

    var model: Launch? = nil {
        didSet {
            configure()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func prepareForReuse() {
        super.prepareForReuse()

        reset()
    }

    func reset() {
        dateLabel.text = ""
        imageDataTask?.cancel()
        imageDataTask = nil
        activityIndicator.stopAnimating()
        missionPatchView.image = nil
    }

    func configure() {
        guard let model = model, let date = model.utcDateString.split(separator: " ").first else {
            reset()
            return
        }

        dateLabel.text = "#\(model.flightNumber) \(model.rocket.rocketName) \(date) "
            + model.launchSite

        successView.result = model.launchSuccess ? .success : .failure

        if let url = URL(string: model.missionPatch) {
            activityIndicator.startAnimating()
            imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    if let data = data {
                        self?.missionPatchView.image = UIImage(data: data)
                    } else {
                        self?.missionPatchView.image = nil
                    }
                }
            }

            imageDataTask?.resume()
        }
    }
}


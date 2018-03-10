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
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    var imageDataTask: URLSessionDataTask?

    var model: Launch? = nil {
        didSet {
            configure()
        }
    }

    var imageViewSize: CGSize {
        return CGSize(width: imageHeightConstraint.constant, height: imageHeightConstraint.constant)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        reset()
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
            return
        }

        dateLabel.text = "#\(model.flightNumber) \(model.rocket.rocketName) \(date) "
            + model.launchSite

        successView.result = model.launchSuccess ? .success : .failure

        if let url = URL(string: model.missionPatch) {
            activityIndicator.startAnimating()
            imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                let image: UIImage?
                if
                    let data = data,
                    let imageViewSize = self?.imageViewSize,
                    let resizedImage = UIImage(data: data)?.resized(toFit: imageViewSize) {
                    image = resizedImage
                } else {
                    image = nil
                }

                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.missionPatchView.image = image
                }
            }

            imageDataTask?.resume()
        }
    }
}

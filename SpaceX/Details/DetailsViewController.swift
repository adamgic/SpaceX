//
//  DetailsViewController.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var linksContainer: UIView!

    @IBOutlet weak var stackView: UIStackView!
    var model: Launch?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    func configure() {
        imageView.image = image

        if let model = model {
            var informations: [String] = [
                "Rocket: \(model.rocket.rocketName)",
                "Location: \(model.launchSite)",
                model.details ?? "",
                "UTC Launch time: \(model.utcDateString)",
                "Local Launch time: \(model.localDateString)"
            ]

            if model.payloads.count > 0 {
                let payloadStrings = model.payloads.map { "\($0.payloadId) (\($0.payloadType))" }
                informations.append("Payload: \(payloadStrings.joined(separator: ", "))")
            }

            label.text = informations.joined(separator: "\n")

            if var links = model.links?.links {
                if let flightClub = model.flightClub {
                    links.append(Link(name: "flight club", url: flightClub))
                }

                links.forEach { link in
                    guard let url = URL(string: link.url) else {
                        return
                    }

                    let name = link.name.replacingOccurrences(of: "_", with: " ")
                    let button = ButtonWithURL(type: .system)
                    button.url = url
                    button.setTitle(name, for: .normal)
                    button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
                    stackView.addArrangedSubview(button)
                }
            }

        }

    }

    @objc func buttonTouchUp(_ sender: ButtonWithURL) {
        guard let url = sender.url else {
            return
        }

        present(SFSafariViewController(url: url), animated: true, completion: nil)
    }
}

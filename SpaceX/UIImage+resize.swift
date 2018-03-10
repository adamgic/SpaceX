//
//  UIImage+resize.swift
//  SpaceX
//
//  Created by Recsio on 10/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import UIKit

extension UIImage {

    func size(thatFits desiredSize: CGSize) -> CGSize {
        if size.width / size.height > desiredSize.width / desiredSize.height {
            let height = CGFloat(ceil(size.height * desiredSize.width / size.width))

            return CGSize(width: desiredSize.width, height: height)
        } else {
            let width = CGFloat(ceil(size.width * desiredSize.height / size.height))

            return CGSize(width: width, height: desiredSize.height)
        }
    }

    func resized(toFit imageViewSize: CGSize) -> UIImage? {
        let outputSize = size(thatFits: imageViewSize)

        UIGraphicsBeginImageContextWithOptions(outputSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: outputSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

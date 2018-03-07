//
//  Rocket.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import Foundation

struct Rocket: Codable {
    let rocketId: String
    let rocketName: String
    let rocketType: String

    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}

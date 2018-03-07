//
//  Payload.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import Foundation

struct Payload: Codable {

    let payloadId: String
    let payloadType: String

    enum CodingKeys: String, CodingKey {
        case payloadId = "payload_id"
        case payloadType = "payload_type"
    }
}

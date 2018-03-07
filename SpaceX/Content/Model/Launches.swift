//
//  Launches.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import Foundation

fileprivate struct IncompleteLaunchData: Codable {}

struct Launches: Decodable {
    let launches: [Launch]

    init(from decoder: Decoder) throws {
        var launches: [Launch] = []
        var container = try decoder.unkeyedContainer()

        while !container.isAtEnd {
            if let launch = try? container.decode(Launch.self) {
                launches.append(launch)
            } else {
                _ = try? container.decode(IncompleteLaunchData.self)
            }
        }
        self.launches = launches
    }
}

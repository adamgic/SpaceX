//
//  Links.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import Foundation

struct Links: Codable {
    let links: [Link]

    struct LinkKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LinkKey.self)

        var links: [Link] = []
        for key in container.allKeys {
            if let url = try? container.decode(String.self, forKey: key) {
                links.append(Link(name: key.stringValue, url: url))
            }
        }
        self.links = links
    }
}


//
//  Content.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import Foundation

class Content {

    static let queue = DispatchQueue(label: "ContentDownloading")
    static func getLaunches(completionHandler: @escaping ([Launch]) -> Void) {

        guard let url = URL(string: "https://api.spacexdata.com/v2/launches/") else {
            completionHandler([])
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completionHandler([])
                return
            }

            do {
                let content = try JSONDecoder().decode(Launches.self, from: data)
                completionHandler(content.launches)
            } catch {
                completionHandler([])
            }
        }
        task.resume()

    }
}


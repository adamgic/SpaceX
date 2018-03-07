//
//  Launch.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import Foundation

struct Launch: Decodable {

    let flightNumber: Int
    let launchYear: String
    let utcDate: Date?
    let localDate: Date?
    let rocket: Rocket
    let details: String?
    let launchSuccess: Bool

    // nested
    let payloads: [Payload]
    var flightClub: String?

    let missionPatch: String
    let launchSite: String

    // custom
    let links: Links?

    var utcDateString: String {
        guard let utcDate = utcDate else { return "" }
        return Launch.outputDateFormatter.string(from: utcDate)
    }

    var localDateString: String {
        guard let localDate = localDate else { return "" }
        return Launch.outputDateFormatter.string(from: localDate)
    }

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case launchYear = "launch_year"
        case utcDate = "launch_date_utc"
        case localDate = "launch_date_local"
        case links
        case rocket
        case details
        case telemetry
        case launchSite = "launch_site"
        case launchSuccess = "launch_success"
    }

    // nested coding keys
    enum RocketCodingKey: String, CodingKey {
        case secondStage = "second_stage"
    }

    enum SecondStageCodingKey: String, CodingKey {
        case payloads
    }

    enum TelemetryCodingKey: String, CodingKey {
        case flightClub = "flight_club"
    }

    enum LinksCodingKey: String, CodingKey {
        case missionPatch = "mission_patch"
    }

    enum LaunchSiteKey: String, CodingKey {
        case siteNameLong = "site_name_long"
    }
}

extension Launch {

    static let utcDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter
    }()

    static let localDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter
    }()

    static let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter
    }()

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        launchYear = try container.decode(String.self, forKey: .launchYear)
        let utcDateString = try container.decode(String.self, forKey: .utcDate)
        utcDate = Launch.utcDateFormatter.date(from: utcDateString)

        let localDateString = try container.decode(String.self, forKey: .localDate)
        let endOfLocalDateIndex = localDateString.index(localDateString.startIndex, offsetBy: 19)
        let localDateOnly = localDateString[..<endOfLocalDateIndex]
        localDate = Launch.localDateFormatter.date(from: String(localDateOnly))

        links = try container.decode(Links.self, forKey: .links)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
        details = try? container.decode(String.self, forKey: .details)

        launchSuccess = try container.decode(Bool.self, forKey: .launchSuccess)

        let rocketContainer = try container.nestedContainer(keyedBy: RocketCodingKey.self, forKey: .rocket)
        let secondStageContainer = try rocketContainer.nestedContainer(keyedBy: SecondStageCodingKey.self, forKey: .secondStage)
        payloads = try secondStageContainer.decode([Payload].self, forKey: .payloads)

        let telemetryContainer = try container.nestedContainer(keyedBy: TelemetryCodingKey.self, forKey: .telemetry)
        flightClub = try? telemetryContainer.decode(String.self, forKey: .flightClub)

        let launchSiteContainer = try container.nestedContainer(keyedBy: LaunchSiteKey.self, forKey: .launchSite)
        launchSite = try launchSiteContainer.decode(String.self, forKey: .siteNameLong)

        let linksContainer = try container.nestedContainer(keyedBy: LinksCodingKey.self, forKey: .links)
        missionPatch = try linksContainer.decode(String.self, forKey: .missionPatch)
    }
}


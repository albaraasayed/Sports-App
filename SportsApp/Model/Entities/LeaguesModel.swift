//
//  LeaguesModel.swift
//  SportsApp
//
//  Created by albaraa alsayed on 18/12/1447 AH.
//

import Foundation

struct LeagueResponse: Decodable {
    let result: [League]?
}

struct League: Decodable {
    let leagueKey: String?
    let leagueName: String?
    let leagueLogo: String?
    let leagueYear: String?
    let countryName: String?

    enum CodingKeys: CodingKey {
        case leagueKey
        case leagueName
        case leagueLogo
        case leagueYear
        case countryName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        leagueName = try container.decodeIfPresent(String.self, forKey: .leagueName)
        leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        leagueYear = try container.decodeIfPresent(String.self, forKey: .leagueYear)
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        
        if let intKey = try? container.decodeIfPresent(Int.self, forKey: .leagueKey) {
            leagueKey = String(intKey)
        } else if let stringKey = try? container.decodeIfPresent(String.self, forKey: .leagueKey) {
            leagueKey = stringKey
        } else {
            leagueKey = nil
        }
    }
}

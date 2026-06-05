//
//  TeamsModel.swift
//  SportsApp
//
//  Created by albaraa alsayed on 18/12/1447 AH.
//

import Foundation

struct TeamResponse: Decodable {
    let result: [Team]?
}

struct Team: Decodable {
    let teamKey: String?
    let teamName: String?
    let teamLogo: String?
    let players: [FootballPlayer]?
    
    enum CodingKeys: CodingKey {
        case teamKey, teamName, teamLogo, players
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        teamName = try container.decodeIfPresent(String.self, forKey: .teamName)
        teamLogo = try container.decodeIfPresent(String.self, forKey: .teamLogo)
        players = try container.decodeIfPresent([FootballPlayer].self, forKey: .players)
        

        if let intKey = try? container.decodeIfPresent(Int.self, forKey: .teamKey) {
            teamKey = String(intKey)
        } else if let stringKey = try? container.decodeIfPresent(String.self, forKey: .teamKey) {
            teamKey = stringKey
        } else {
            teamKey = nil
        }
    }
}

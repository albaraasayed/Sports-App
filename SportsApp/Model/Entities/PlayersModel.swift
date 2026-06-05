//
//  PlayersModel.swift
//  SportsApp
//
//  Created by albaraa alsayed on 18/12/1447 AH.
//

import Foundation

struct FootballPlayer: Decodable {
    let playerName: String?
    let playerNumber: String?
    let playerAge: String?
    let playerImage: String?
    let playerMatchPlayed: String?
    let playerType: String?
    let playerRedCards: String?
    let playerYellowCards: String?
    let playerGoals: String?
    let playerCountry: String?
}


struct TennisPlayerResponse: Decodable {
    let result: [TennisPlayer]?
}

struct TennisPlayer: Decodable {
    let playerKey: String?
    let playerName: String?
    let playerLogo: String?
    let playerCountry: String?
    let playerBday: String?
    let stats: [TennisStat]?
    let tournaments: [TennisTournament]?
    
    enum CodingKeys: CodingKey {
        case playerKey, playerName, playerLogo, playerCountry, playerBday, stats, tournaments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        playerName = try container.decodeIfPresent(String.self, forKey: .playerName)
        playerLogo = try container.decodeIfPresent(String.self, forKey: .playerLogo)
        playerCountry = try container.decodeIfPresent(String.self, forKey: .playerCountry)
        playerBday = try container.decodeIfPresent(String.self, forKey: .playerBday)
        stats = try container.decodeIfPresent([TennisStat].self, forKey: .stats)
        tournaments = try container.decodeIfPresent([TennisTournament].self, forKey: .tournaments)
        
        if let intKey = try? container.decodeIfPresent(Int.self, forKey: .playerKey) {
            playerKey = String(intKey)
        } else if let stringKey = try? container.decodeIfPresent(String.self, forKey: .playerKey) {
            playerKey = stringKey
        } else {
            playerKey = nil
        }
    }
}



struct TennisStat: Decodable {
    let season: String?
    let type: String?
    let rank: String?
    let titles: String?
    let matchesWon: String?
    let matchesLost: String?
    let hardWon: String?
    let hardLost: String?
    let clayWon: String?
    let clayLost: String?
    let grassWon: String?
    let grassLost: String?
}


struct TennisTournament: Decodable {
    let name: String?
    let season: String?
    let type: String?
    let surface: String?
    let prize: String?
}



//
//  FixturesModel.swift
//  SportsApp
//
//  Created by albaraa alsayed on 18/12/1447 AH.
//

import Foundation

struct FixtureResponse: Decodable {
    let result: [Fixture]?
}

struct Fixture: Decodable {

    let eventTime: String?
    let eventFinalResult: String?
    let leagueLogo: String?
    let eventStadium: String?
    let leagueRound: String?
    let eventStatus: String?
    
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let eventFirstPlayer: String?
    let eventSecondPlayer: String?
    
    // Logos
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    
    // Dates
    let eventDate: String?
    let eventDateStart: String?
    
    
    var homeName: String? {
        return eventHomeTeam ?? eventFirstPlayer
    }
    
    var awayName: String? {
        return eventAwayTeam ?? eventSecondPlayer
    }
    
    var homeLogo: String? {
        return homeTeamLogo ?? eventHomeTeamLogo ?? eventFirstPlayerLogo
    }
    
    var awayLogo: String? {
        return awayTeamLogo ?? eventAwayTeamLogo ?? eventSecondPlayerLogo
    }
    
    var date: String? {
        return eventDate ?? eventDateStart
    }
}

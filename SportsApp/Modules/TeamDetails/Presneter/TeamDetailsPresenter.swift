//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by albaraa alsayed on 19/12/1447 AH.
//

import Foundation

protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class TeamDetailsPresenter: TeamDetailsPresenterProtocol {
    
    weak var view: TeamDetilsVCProtocol?
    var sportType: SportType
    var teamId: String
    
    init(view: TeamDetilsVCProtocol, sportType: SportType, teamId: String) {
        self.view = view
        self.sportType = sportType
        self.teamId = teamId
    }
    
    func viewDidLoad() {
        view?.showLoading()
        
        NetworkManager.shared.fetchTeam(sport: sportType, teamId: teamId) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success(let teams):
                    if let firstTeam = teams.first, let players = firstTeam.players {
                        self.view?.loadPlayers(players: players, teamName: firstTeam.teamName ?? "Team Name")
                        
                    } else {
                        self.view?.showError(message: "No players found for this team.")
                    }
                    
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
}

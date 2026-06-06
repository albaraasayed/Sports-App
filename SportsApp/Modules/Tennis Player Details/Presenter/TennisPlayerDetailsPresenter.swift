//
//  TennisPlayerDetailsPresenter.swift
//  SportsApp
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import Foundation

protocol TennisPlayerDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class TennisPlayerDetailsPresenter: TennisPlayerDetailsPresenterProtocol {
    
    private weak var view: TennisPlayerDetailsViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let playerId: String

    init(view: TennisPlayerDetailsViewProtocol, playerId: String, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.view = view
        self.playerId = playerId
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        fetchPlayerDetails()
    }
    
    private func fetchPlayerDetails() {
        view?.showLoading()
        
        networkManager.fetchTennisPlayer(playerId: playerId) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.view?.hideLoading()
                
                switch result {
                case .success(let players):
                    if let player = players.first {
                        self.view?.loadPlayerDetails(tennisPlayer: player)
                    }
                case .failure(let error):
                    print("Error fetching player details: \(error.localizedDescription)")
                }
            }
        }
    }
}

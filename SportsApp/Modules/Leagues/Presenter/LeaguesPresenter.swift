//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by albaraa alsayed on 16/12/1447 AH.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectLeague(at index: Int)
    func setSportType(sport: SportType)
    func searchLeagues(with query: String)
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    var sportType: SportType?
    
    var allLeagues: [League] = []
    var leagues: [League] = []
    
    init(view: LeaguesViewProtocol, sportType: SportType) {
        self.view = view
        self.sportType = sportType
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        guard let sportType = sportType else { return }
        
        view?.showLoading()

        NetworkManager.shared.fetchLeagues(sport: sportType) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.view?.hideLoading()
                
                switch result {
                case .success(let fetchedLeagues):
                    self.allLeagues = fetchedLeagues
                    self.leagues = fetchedLeagues
                    self.view?.displayLeagues(leagues: self.leagues)
                    
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                    print("Error fetching leagues: \(error)")
                }
            }
        }
    }
    
    func searchLeagues(with query: String) {
        if query.isEmpty {
            self.leagues = allLeagues
        } else {
            self.leagues = allLeagues.filter { league in
                guard let name = league.leagueName else { return false }
                return name.lowercased().contains(query.lowercased())
            }
        }
        
        view?.displayLeagues(leagues: self.leagues)
    }
    
    func didSelectLeague(at index: Int) { }
    
    func setSportType(sport: SportType) {
        self.sportType = sport
    }
}

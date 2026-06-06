//
//  FavoritePresenter.swift
//  SportsApp
//
//  Created by albaraa alsayed on 19/12/1447 AH.
//

import Foundation


protocol FavoritePresenterProtocol {
    func loadFavorites()
    func deleteFavorite(id: String)
}


class FavoritePresenter: FavoritePresenterProtocol {
    private weak var view: FavoriteViewProtocol?
    
    init(view: FavoriteViewProtocol) {
        self.view = view
    }
    
    func loadFavorites() {
        let favorites = CoreDataManager.shared.fetchFavorites()
        view?.updateFavorites(favorites)
    }
    
    func deleteFavorite(id: String) {
        CoreDataManager.shared.deleteLeague(leagueId: id)
        loadFavorites()
    }
}

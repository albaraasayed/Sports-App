//
//  FavoriteVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 19/12/1447 AH.
//

import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func updateFavorites(_ favorites: [FavoriteEntity])
}

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites: [FavoriteEntity] = []
    lazy var presenter = FavoritePresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadFavorites()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.leaguesCell, bundle: nil), forCellReuseIdentifier: Constants.leaguesCell)
    }
}


extension FavoriteVC: FavoriteViewProtocol {
    func updateFavorites(_ favorites: [FavoriteEntity]) {
        self.favorites = favorites
        self.tableView.reloadData()
    }
}


extension FavoriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.leaguesCell, for: indexPath) as? LeaguesCell else {
            return UITableViewCell()
        }
        
        let fav = favorites[indexPath.row]
        let sportString = fav.sportType?.capitalized ?? "Sport"
        let countryString = fav.country?.capitalized ?? "Country"
        let formattedSubtitle = "\(sportString) / \(countryString)"
        
        cell.configureBasicInfo(name: fav.name ?? "League Name", subtitle: formattedSubtitle, isFavorite: true)
        cell.setLocalImage(from: fav.logoData, sportType: SportType(rawValue: fav.sportType!) ?? .tennis)
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favLeague = favorites[indexPath.row]
            
            if let id = favLeague.leagueId {
                presenter.deleteFavorite(id: id)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        NetworkConnection.shared.isOnline(on: self) {
            [weak self] in
            guard let self else { return }
            
            let favLeague = favorites[indexPath.row]
            
            guard let id = favLeague.leagueId else { return }
            guard let name = favLeague.name else { return }
            guard let sport = favLeague.sportType else { return }
            guard let sportType = SportType(rawValue: sport) else { return }
            
            let sb = UIStoryboard(name: Constants.leagueDetailsVC, bundle: nil)
            let vc = sb.instantiateViewController(identifier: Constants.leagueDetailsVC) { coder in
                return LeagueDetailsVC(coder: coder, sportType: sportType, leagueId: id, leagueName: name)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FavoriteVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


extension FavoriteVC: LeagueCellDelegate {
    func didTapFavoriteButton(on cell: LeaguesCell, isFavoriteNow : Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let favLeague = favorites[indexPath.row]
        
        if !isFavoriteNow {
            AlertManager.showDeleteConfirmationAlert(on: self, title: String(localized: "Remove Favorite"), message: String(localized: "Are you sure you want to remove this league from your favorites?")) { [weak self] in
                if let id = favLeague.leagueId {
                    self?.presenter.deleteFavorite(id: id)
                }
            } cancelHandler: {
                
            }
        }
    }
}

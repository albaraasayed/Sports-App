//
//  LeaguesVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 11/12/1447 AH.
//

import UIKit
import SDWebImage

protocol LeaguesViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayLeagues(leagues: [League])
    func showError(message: String)
}

class LeaguesVC: UIViewController {
    var leaguePresenter: LeaguesPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leagueLabel: UILabel!
    
    var leaguesArray: [League] = []
    
    var sportType: SportType?
    
    init(coder: NSCoder, sportType: SportType) {
        self.sportType = sportType
        super.init(coder: coder)!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sportType = self.sportType {
            leaguePresenter = LeaguesPresenter(view: self, sportType: sportType)
            leaguePresenter?.viewDidLoad()
        }
        
        searchBar.delegate = self
        setupTableView()
        print(leaguesArray.count)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.leaguesCell, bundle: nil), forCellReuseIdentifier: Constants.leaguesCell)
    }
}


extension LeaguesVC: LeaguesViewProtocol {
    
    func showError(message: String) { }
    
    func showLoading() { }
    
    func hideLoading() { }
    
    func displayLeagues(leagues: [League]) {
        self.leaguesArray = leagues
        tableView.reloadData()
    }
}

extension LeaguesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.leaguesCell, for: indexPath) as? LeaguesCell else {
            return UITableViewCell()
        }
        
        let currentLeague = leaguesArray[indexPath.row]
        
        let name = currentLeague.leagueName ?? "Unknown League"
        let logoURLString = currentLeague.leagueLogo ?? ""
        
        cell.leagueLabel.text = name
        
        if let imageURL = URL(string: logoURLString), !logoURLString.isEmpty {
            cell.leagueImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "image-placeholder"))
        } else {
            cell.leagueImage.image = UIImage(named: "image-placeholder")
        }
        
        switch sportType {
        case .football, .basketball, .tennis:
            cell.sportNameLabel.text = currentLeague.countryName ?? "Unknown Country"
            
        case .cricket:
            cell.sportNameLabel.text = currentLeague.leagueYear ?? "Unknown Year"
            
        default:
            cell.sportNameLabel.text = ""
        }
        
        return cell
    }
}


extension LeaguesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentLeague = leaguesArray[indexPath.row]
        
        guard let currentSport = sportType,
              let selectedLeagueId = currentLeague.leagueKey,
              let selectedLeagueName = currentLeague.leagueName else {
            return
        }
        
        let sb = UIStoryboard(name: Constants.LeagueDetailsVC, bundle: nil)
        
        let vc: LeagueDetailsVC = sb.instantiateViewController(identifier: Constants.LeagueDetailsVC, creator: { coder in
            return LeagueDetailsVC(coder: coder, sportType: currentSport, leagueId: selectedLeagueId, leagueName: selectedLeagueName)
        })
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension LeaguesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        leaguePresenter?.searchLeagues(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        leaguePresenter?.searchLeagues(with: "")
    }
}

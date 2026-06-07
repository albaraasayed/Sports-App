//
//  LeaguesVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 11/12/1447 AH.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

protocol LeaguesViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayLeagues(leagues: [League])
    func showError(message: String)
}

class LeaguesVC: UIViewController {
    var leaguePresenter: LeaguesPresenterProtocol?
    var leaguesArray: [League] = []
    var sportType: SportType?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leagueLabel: UILabel!
    
    var loadingIndicator: NVActivityIndicatorView!
    
    init(coder: NSCoder, sportType: SportType) {
        self.sportType = sportType
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupTableView()
        setupIndicator()
        
        if let sportType = self.sportType {
            self.leaguePresenter = LeaguesPresenter(view: self, sportType: sportType)
            self.leaguePresenter?.viewDidLoad()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.leaguesCell, bundle: nil), forCellReuseIdentifier: Constants.leaguesCell)
    }
    
    private func setupIndicator() {
        let indicatorSize: CGFloat = 50
        let frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse, color: .Primary, padding: nil)
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    
    private func getPlaceholderImage(for sport: SportType?) -> UIImage {
        switch sport {
        case .football:
            return UIImage(named: "Football Placeholder") ?? UIImage(named: "image-placeholder")!
        case .basketball:
            return UIImage(named: "Basketball Placeholder") ?? UIImage(named: "image-placeholder")!
        case .cricket:
            return UIImage(named: "Cricket Placeholder") ?? UIImage(named: "image-placeholder")!
        case .tennis:
            return UIImage(named: "Tennis Placeholder") ?? UIImage(named: "image-placeholder")!
        default:
            return UIImage(named: "image-placeholder")!
        }
    }
}

extension LeaguesVC: LeaguesViewProtocol {
    func showError(message: String) { }
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    func displayLeagues(leagues: [League]) {
        self.leaguesArray = leagues
        tableView.reloadData()
    }
}

extension LeaguesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.leaguesCell, for: indexPath) as? LeaguesCell else {
            return UITableViewCell()
        }
        
        let currentLeague = leaguesArray[indexPath.row]
        let leagueId = "\(currentLeague.leagueKey ?? "0")"
        let isFav = leaguePresenter?.isFavorite(leagueId: leagueId) ?? false
        
        let subtitleText: String
        if sportType == .cricket {
            subtitleText = currentLeague.leagueYear ?? "Year"
        } else {
            subtitleText = currentLeague.countryName ?? "Country"
        }
        
        let placeholder = getPlaceholderImage(for: sportType)
        
        cell.configureBasicInfo(name: currentLeague.leagueName ?? "League", subtitle: subtitleText, isFavorite: isFav)
        
        if let logoString = currentLeague.leagueLogo, let url = URL(string: logoString) {
            cell.leagueImage.sd_setImage(with: url, placeholderImage: placeholder)
        } else {
            cell.leagueImage.image = placeholder
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentLeague = leaguesArray[indexPath.row]
        guard let currentSport = sportType, let selectedLeagueId = currentLeague.leagueKey, let selectedLeagueName = currentLeague.leagueName else { return }
        
        NetworkConnection.shared.isOnline(on: self) {
            let sb = UIStoryboard(name: Constants.leagueDetailsVC, bundle: nil)
            let vc: LeagueDetailsVC = sb.instantiateViewController(identifier: Constants.leagueDetailsVC, creator: { coder in
                return LeagueDetailsVC(coder: coder, sportType: currentSport, leagueId: selectedLeagueId, leagueName: selectedLeagueName)
            })
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}



extension LeaguesVC: LeagueCellDelegate {
    func didTapFavoriteButton(on cell: LeaguesCell, isFavoriteNow : Bool) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let selectedLeague = leaguesArray[indexPath.row]
        
        if !isFavoriteNow {
            AlertManager.showDeleteConfirmationAlert(on: self, title: String(localized: "Remove Favorite"), message: String(localized: "Are you sure you want to remove this league from your favorites?")) { [weak self] in
                self?.leaguePresenter?.toggleFavorite(league: selectedLeague, isNowFavorite: false)
                cell.configureBasicInfo(name: selectedLeague.leagueName ?? "", subtitle: cell.sportNameLabel.text ?? "", isFavorite: false)
            } cancelHandler: {
                
            }
        } else {
            leaguePresenter?.toggleFavorite(league: selectedLeague, isNowFavorite: true)
            cell.configureBasicInfo(name: selectedLeague.leagueName ?? "", subtitle: cell.sportNameLabel.text ?? "", isFavorite: true)
        }
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

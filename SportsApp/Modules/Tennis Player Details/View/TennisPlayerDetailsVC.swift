//
//  TennisPlayerDetialsVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

protocol TennisPlayerDetailsViewProtocol: AnyObject {
    func hideLoading()
    func showLoading()
    func loadPlayerDetails(tennisPlayer: TennisPlayer)
}

class TennisPlayerDetailsVC: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerCountry: UILabel!
    @IBOutlet weak var playerBirthDate: UILabel!
    
    @IBOutlet weak var statsTournamentsSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var loadingIndicator: NVActivityIndicatorView!
    
    var playerId: String?
    var presenter: TennisPlayerDetailsPresenterProtocol?
    
    var statsList: [TennisStat] = []
    var tournamentsList: [TennisTournament] = []
    
    init(coder: NSCoder, playerId: String) {
        self.playerId = playerId
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupIndicator()
        
        if let id = playerId {
            presenter = TennisPlayerDetailsPresenter(view: self, playerId: id)
            presenter?.viewDidLoad()
        }
        
        statsTournamentsSegment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    private func setupUI() {
        playerImage.layer.cornerRadius = playerImage.frame.width / 2
        playerImage.layer.borderWidth = 2
        playerImage.layer.borderColor = UIColor.Primary.cgColor
        playerImage.clipsToBounds = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: Constants.statsCell, bundle: nil), forCellReuseIdentifier: Constants.statsCell)
        tableView.register(UINib(nibName: Constants.tournamentsCell, bundle: nil), forCellReuseIdentifier: Constants.tournamentsCell)
    }
    
    private func setupIndicator() {
        let indicatorSize: CGFloat = 50
        let frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse, color: .Primary, padding: nil)
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    
    @objc private func segmentChanged() {
        tableView.reloadData()
    }
}



extension TennisPlayerDetailsVC: TennisPlayerDetailsViewProtocol {
    
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func loadPlayerDetails(tennisPlayer: TennisPlayer) {
        
        playerName.text = tennisPlayer.playerName ?? "Unknown Player"
        playerCountry.text = tennisPlayer.playerCountry ?? "Unknown Country"
        playerBirthDate.text = tennisPlayer.playerBday ?? "Unknown Date"
        
        if let imageString = tennisPlayer.playerLogo, let url = URL(string: imageString) {
            playerImage.sd_setImage(with: url, placeholderImage: UIImage(named: "player-placeholder"))
        } else {
            playerImage.image = UIImage(named: "player-placeholder")
        }
    
        self.statsList = tennisPlayer.stats ?? []
        self.tournamentsList = tennisPlayer.tournaments ?? []
        
        tableView.reloadData()
    }
}



extension TennisPlayerDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statsTournamentsSegment.selectedSegmentIndex == 0 {
            return statsList.count
        } else {
            return tournamentsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if statsTournamentsSegment.selectedSegmentIndex == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.statsCell, for: indexPath) as? StatsCell else {
                return UITableViewCell()
            }
            
            let stat = statsList[indexPath.row]
            cell.configure(with: stat)
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tournamentsCell, for: indexPath) as? TournamentsCell else {
                return UITableViewCell()
            }
            
            let tournament = tournamentsList[indexPath.row]
            cell.configure(with: tournament)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return statsTournamentsSegment.selectedSegmentIndex == 0 ? 230 : 152
    }
}

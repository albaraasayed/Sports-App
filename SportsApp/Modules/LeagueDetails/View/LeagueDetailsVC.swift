//
//  LeagueDetailsVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 12/12/1447 AH.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

protocol LeagueDetailsVCProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func reloadData(teams: [Team], tennisPlayers: [TennisPlayer], upcoming: [Fixture], past: [Fixture])
    func updateFavoriteButtonState(isFavorite: Bool)
}

class LeagueDetailsVC: UIViewController {
    
    lazy var favButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapFavButton))
    }()
    
    @objc private func didTapFavButton() {
        if presenter?.isFavorite == true {
            AlertManager.showDeleteConfirmationAlert(on: self, title: String(localized: "Remove Favorite"), message: String(localized: "Are you sure you want to remove this league from your favorites?")) { [weak self] in
                self?.presenter?.toggleFavorite()
            }
        } else {
            presenter?.toggleFavorite()
        }
    }
    
    var sportType: SportType?
    var leagueId: String?
    var leagueName: String?
    var presenter: LeagueDetailsPresenter?
    
    var teams: [Team] = []
    var tennisPlayers: [TennisPlayer] = []
    var upcomingMatches: [Fixture] = []
    var pastMatches: [Fixture] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leagueNameStackView: UIStackView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    var loadingIndicator: NVActivityIndicatorView!
    
    init(coder: NSCoder, sportType: SportType, leagueId: String, leagueName: String) {
        self.sportType = sportType
        self.leagueId = leagueId
        self.leagueName = leagueName
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        leagueNameLabel.text = leagueName
        
        
        if let currentSport = self.sportType, let currentLeagueId = self.leagueId, let currentLeagueName = self.leagueName {
            self.presenter = LeagueDetailsPresenter(view: self, sportType: currentSport, leagueId: currentLeagueId, leagueName: currentLeagueName)
            self.presenter?.viewDidLoad()
        }
    }
    
    private func setupUI() {
        leagueNameStackView.layer.cornerRadius = 12
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: Constants.teamsCell, bundle: .main), forCellWithReuseIdentifier: Constants.teamsCell)
        collectionView.register(UINib(nibName: Constants.upcomingCell, bundle: .main), forCellWithReuseIdentifier: Constants.upcomingCell)
        collectionView.register(UINib(nibName: Constants.resultMatchCell, bundle: .main), forCellWithReuseIdentifier: Constants.resultMatchCell)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        navigationItem.rightBarButtonItem = favButton
        
        let indicatorSize: CGFloat = 50
        let frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse, color: .Primary, padding: nil)
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, enviroment in
            guard let self = self else { return nil }
            switch sectionIndex {
            case 0: return self.teamsSection()
            case 1: return self.upcomingSection()
            default: return self.resultMatchsSection()
            }
        }
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        return header
    }
    
    private func teamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(134))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 8)
        section.orthogonalScrollingBehavior = .continuous
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.maxX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
    
    private func upcomingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94), heightDimension: .absolute(190))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 42, leading: 16, bottom: 0, trailing: 8)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createHeader()]
        return section
    }
    
    private func resultMatchsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 26, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [createHeader()]
        return section
    }
    
    
    private func getPlaceholder(for sport: SportType?) -> UIImage {
        switch sport {
        case .basketball:
            return UIImage(named: "Basketball Placeholder") ?? UIImage(named: "image-placeholder")!
        case .football:
            return UIImage(named: "Football Placeholder") ?? UIImage(named: "image-placeholder")!
        case .cricket:
            return UIImage(named: "Cricket Placeholder") ?? UIImage(named: "image-placeholder")!
        case .tennis:
            return UIImage(named: "Tennis Placeholder") ?? UIImage(named: "image-placeholder")!
        default:
            return UIImage(named: "image-placeholder")!
        }
    }
}

extension LeagueDetailsVC: LeagueDetailsVCProtocol {
    func updateFavoriteButtonState(isFavorite: Bool) {
        let imageName = isFavorite ? "star.fill" : "star"
        favButton.image = UIImage(systemName: imageName)
    }
    
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func reloadData(teams: [Team], tennisPlayers: [TennisPlayer], upcoming: [Fixture], past: [Fixture]) {
        self.teams = teams
        self.tennisPlayers = tennisPlayers
        self.upcomingMatches = upcoming
        self.pastMatches = past
        collectionView.reloadData()
    }
}

extension LeagueDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 3 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return sportType == .tennis ? tennisPlayers.count : teams.count
        case 1: return upcomingMatches.count
        case 2: return pastMatches.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let placeholderImage = getPlaceholder(for: sportType)
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.teamsCell, for: indexPath) as? TeamsCell else { return UICollectionViewCell() }
            
            cell.teamNameLabel.text = teams[indexPath.row].teamName
            if let logoString = (sportType == .tennis ? tennisPlayers[indexPath.row].playerLogo : teams[indexPath.row].teamLogo),
               let url = URL(string: logoString) {
                cell.imageView.sd_setImage(with: url, placeholderImage: placeholderImage)
            } else {
                cell.imageView.image = placeholderImage
            }
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.upcomingCell, for: indexPath) as? UpcomingCell else { return UICollectionViewCell() }
            let match = upcomingMatches[indexPath.row]
            cell.team1Image.sd_setImage(with: URL(string: match.homeLogo ?? ""), placeholderImage: placeholderImage)
            cell.team2Image.sd_setImage(with: URL(string: match.awayLogo ?? ""), placeholderImage: placeholderImage)
            cell.leagueImage.sd_setImage(with: URL(string: match.leagueLogo ?? ""), placeholderImage: placeholderImage)
            
            cell.team1Label.text = match.homeName
            cell.team2Label.text = match.awayName
            cell.time.text = match.eventTime
            cell.date.text = match.date
            cell.leagueRound.text = match.leagueRound
            
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.resultMatchCell, for: indexPath) as? ResultMatchCell else { return UICollectionViewCell() }
            let match = pastMatches[indexPath.row]
            cell.team1Image.sd_setImage(with: URL(string: match.homeLogo ?? ""), placeholderImage: placeholderImage)
            cell.team2Image.sd_setImage(with: URL(string: match.awayLogo ?? ""), placeholderImage: placeholderImage)
            cell.leagueLogo.sd_setImage(with: URL(string: match.leagueLogo ?? ""), placeholderImage: placeholderImage)
            
            
            cell.team1Label.text = match.homeName
            cell.team2Label.text = match.awayName
            
            let resultString = match.eventFinalResult ?? "-"
            let results = resultString.components(separatedBy: " - ")
            if results.count == 2 {
                cell.team1Result.text = results[0].trimmingCharacters(in: .whitespaces)
                cell.team2Result.text = results[1].trimmingCharacters(in: .whitespaces)
            } else {
                cell.team1Result.text = resultString
                cell.team2Result.text = ""
            }
            
            cell.leagueRound.text = match.leagueRound
            cell.eventStadium.text = match.eventStadium
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        
        if indexPath.section == 1 {
            header.dateLabel.text = upcomingMatches.isEmpty ? String(localized: "No Upcoming Matches") : String(localized: "Upcoming Matches")
        } else if indexPath.section == 2 {
            header.dateLabel.text = pastMatches.isEmpty ? String(localized: "No Recent Results") : String(localized: "Recent Results")
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if sportType == .football {
                let sb = UIStoryboard(name: Constants.teamDetailsVC, bundle: nil)
                let selectedTeam = teams[indexPath.row]
                guard let id = selectedTeam.teamKey, let currentSport = sportType else { return }
                
                NetworkConnection.shared.isOnline(on: self) {
                    let vc: TeamDetailsVC = sb.instantiateViewController(identifier: Constants.teamDetailsVC, creator: { coder in
                        return TeamDetailsVC(coder: coder, sportType: currentSport, teamId: id)
                    })
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            } else if sportType == .tennis {
                let sb = UIStoryboard(name: Constants.tennisPlayerDetialsVC, bundle: nil)
                let selectedPlayer = tennisPlayers[indexPath.row]
                
                guard let id = selectedPlayer.playerKey else { return }
                let playerIdString = "\(id)"
                
                NetworkConnection.shared.isOnline(on: self) {
                    let vc: TennisPlayerDetailsVC = sb.instantiateViewController(identifier: Constants.tennisPlayerDetialsVC, creator: { coder in
                        return TennisPlayerDetailsVC(coder: coder, playerId: playerIdString)
                    })
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                AlertManager.showNoInternetAlert(on: self, title: String(localized: "Comming Soon"), message: String(localized: "This Feature is not available."))
            }
            
        default: return
        }
    }
}

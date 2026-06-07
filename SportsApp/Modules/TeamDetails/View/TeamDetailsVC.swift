//
//  TeamDetailsVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 13/12/1447 AH.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

protocol TeamDetilsVCProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func loadPlayers(players: [FootballPlayer], teamName: String)
    func showError(message: String)
    func reloadData()
}

class TeamDetailsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var allCircles: [UIView]!
    
    @IBOutlet weak var goalKeeper: UIView!
    @IBOutlet var defenders: [UIView]!
    @IBOutlet var midfielders: [UIView]!
    @IBOutlet var forward: [UIView]!
    
    @IBOutlet weak var teamName: UILabel!
    
    var loadingIndicator: NVActivityIndicatorView!
    
    var presenter: TeamDetailsPresenterProtocol?
    var sportType: SportType?
    var teamId: String?
    
    var players: [FootballPlayer] = []
    
    var currentIndex: Int = 0 {
        didSet {
            updatePlaygroundSelection()
        }
    }
    
    init(coder: NSCoder, sportType: SportType, teamId: String) {
        self.sportType = sportType
        self.teamId = teamId
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupIndicator()
        
        if let currentSport = self.sportType, let currentTeamId = self.teamId {
            self.presenter = TeamDetailsPresenter(view: self, sportType: currentSport, teamId: currentTeamId)
            self.presenter?.viewDidLoad()
        }
    }
    
    private func setupUI() {
        allCircles.forEach { circle in
            circle.layer.cornerRadius = circle.frame.height / 2
            circle.layer.borderWidth = 1
            circle.layer.borderColor = UIColor.white.cgColor
        }
        
        self.title = String(localized: "Team Details")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupIndicator() {
        let indicatorSize: CGFloat = 50
        let frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse, color: .Primary, padding: nil)
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.playerCell, bundle: nil), forCellWithReuseIdentifier: Constants.playerCell)
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, environment) in
            guard let self = self else { return }
            
            let containerWidth = environment.container.contentSize.width
            let centerX = offset.x + (containerWidth / 2.0)
            var closestDistance = CGFloat.greatestFiniteMagnitude
            var newIndex = self.currentIndex
            
            items.forEach { item in
                let distanceFromCenter = abs(item.frame.midX - centerX)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                
                if distanceFromCenter < closestDistance {
                    closestDistance = distanceFromCenter
                    newIndex = item.indexPath.item
                }
            }
            
            if self.currentIndex != newIndex {
                DispatchQueue.main.async {
                    self.currentIndex = newIndex
                }
            }
        }
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func updatePlaygroundSelection() {
        allCircles.forEach { $0.backgroundColor = .Primary }
        
        guard !players.isEmpty, currentIndex >= 0, currentIndex < players.count else { return }
        
        let currentPlayer = players[currentIndex]
        let position = currentPlayer.playerType ?? ""
        
        if position.contains("Goalkeeper") {
            goalKeeper.backgroundColor = .white
        } else if position.contains("Defender") {
            let randomCircle = defenders.randomElement()
            randomCircle?.backgroundColor = .white
        } else if position.contains("Midfielder") {
            let randomCircle = midfielders.randomElement()
            randomCircle?.backgroundColor = .white
        } else if position.contains("Forward") || position.contains("Attacker") {
            let randomCircle = forward.randomElement()
            randomCircle?.backgroundColor = .white
        }
    }
    
    @IBAction func didTapRightButton() {
        guard currentIndex < players.count - 1 else { return }
        scrollToItem(at: currentIndex + 1)
    }
    
    @IBAction func didTapleftButton() {
        guard currentIndex > 0 else { return }
        scrollToItem(at: currentIndex - 1)
    }
    
    private func scrollToItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension TeamDetailsVC: UICollectionViewDelegate { }

extension TeamDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.playerCell, for: indexPath) as? PlayerCell else {
            return UICollectionViewCell()
        }
        
        let player = players[indexPath.row]
        
        cell.playerNameLabel.text = player.playerName ?? "Player Name"
        cell.playerNumber.text = player.playerNumber ?? "-"
        cell.playerAge.text = player.playerAge ?? "-"
        cell.playerCountry.text = player.playerCountry ?? "Player Country"
        
        cell.matchPlayed.text = player.playerMatchPlayed ?? "0"
        cell.totalGoals.text = player.playerGoals ?? "0"
        cell.yellowCards.text = player.playerYellowCards ?? "0"
        cell.redCards.text = player.playerRedCards ?? "0"
        
        if let imageString = player.playerImage, let url = URL(string: imageString) {
            cell.playerImage.sd_setImage(with: url, placeholderImage: UIImage(named: "player-placeholder"))
        } else {
            cell.playerImage.image = UIImage(named: "player-placeholder")
        }
        
        return cell
    }
}

extension TeamDetailsVC: TeamDetilsVCProtocol {
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func loadPlayers(players: [FootballPlayer], teamName: String) {
        self.players = players
        self.teamName.text = teamName
        self.collectionView.reloadData()
        self.updatePlaygroundSelection()
    }
    
    func showError(message: String) {
        print("Error: \(message)")
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
}

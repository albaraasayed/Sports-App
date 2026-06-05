//
//  HomeVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 06/12/1447 AH.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    let sportsList: [SportType] = [.football, .basketball, .cricket, .tennis]
    var sportType: SportType = .football
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "SportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        
        let currentSport = sportsList[indexPath.item]
        
        switch currentSport {
        case .football:
            cell.image.image = UIImage(named: "football")
            cell.sportLabel.text = "Football"
        case .basketball:
            cell.image.image = UIImage(named: "basketball")
            cell.sportLabel.text = "Basketball"
        case .cricket:
            cell.image.image = UIImage(named: "cricket")
            cell.sportLabel.text = "Cricket"
        case .tennis:
            cell.image.image = UIImage(named: "tennis")
            cell.sportLabel.text = "Tennis"
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        sportType = sportsList[indexPath.item]
        
        NetworkConnection.shared.isOnline(on: self) {
            let sb = UIStoryboard(name: Constants.leaguesVC, bundle: nil)
            let vc = sb.instantiateViewController(identifier: Constants.leaguesVC) { [weak self] coder in
                guard let self else { return UIViewController(nibName: nil, bundle: nil) }
                return LeaguesVC(coder: coder, sportType: self.sportType)
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalWidthSpacing: CGFloat = 30
        let totalWidth = collectionView.bounds.width - totalWidthSpacing
        let widthPerItem = floor(totalWidth / 2) - 1
        
        let totalHeightSpacing: CGFloat = 30
        let totalHeight = collectionView.bounds.height - totalHeightSpacing
        let heightPerItem = floor(totalHeight / 2) - 1
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

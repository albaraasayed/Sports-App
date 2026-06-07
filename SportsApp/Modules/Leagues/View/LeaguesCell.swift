//
//  LeaguesCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 11/12/1447 AH.
//

import UIKit
import SDWebImage

protocol LeagueCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: LeaguesCell, isFavoriteNow: Bool)
}

class LeaguesCell: UITableViewCell {
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    weak var delegate: LeagueCellDelegate?
    
    private var isFavoriteState: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImage.layer.cornerRadius = leagueImage.frame.width / 2
        leagueImage.clipsToBounds = true
    }
    
    @IBAction func didTapFavButton(_ sender: Any) {
        delegate?.didTapFavoriteButton(on: self, isFavoriteNow: !isFavoriteState)
    }
    
    func configureBasicInfo(name: String, subtitle: String, isFavorite: Bool) {
        self.leagueLabel.text = name
        self.sportNameLabel.text = subtitle
        self.isFavoriteState = isFavorite
        updateStarIcon()
    }
    
    func setNetworkImage(from urlString: String, placeholder: UIImage? = UIImage(named: "image-placeholder")) {
        if let url = URL(string: urlString) {
            leagueImage.sd_setImage(with: url, placeholderImage: placeholder)
        } else {
            leagueImage.image = placeholder
        }
    }
    
    func setLocalImage(from data: Data?, sportType: SportType) {
        if let imageData = data, let image = UIImage(data: imageData) {
            leagueImage.image = image
        } else {
            switch sportType {
            case .basketball: leagueImage.image = UIImage(named: "Basketball Placeholder")!
            case .football : leagueImage.image = UIImage(named: "Football Placeholder")!
            case .cricket : leagueImage.image = UIImage(named: "Cricket Placeholder")!
            default: leagueImage.image = UIImage(named: "Tennis Placeholder")!
            }
            
        }
    }
    
    private func updateStarIcon() {
        let starImageName = isFavoriteState ? "star.fill" : "star"
        favButton.setImage(UIImage(systemName: starImageName), for: .normal)
    }
}

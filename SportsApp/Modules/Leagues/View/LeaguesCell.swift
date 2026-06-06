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
        isFavoriteState.toggle()
        updateStarIcon()
        delegate?.didTapFavoriteButton(on: self, isFavoriteNow: isFavoriteState)
    }
    
    func configureBasicInfo(name: String, subtitle: String, isFavorite: Bool) {
        self.leagueLabel.text = name
        self.sportNameLabel.text = subtitle
        self.isFavoriteState = isFavorite
        updateStarIcon()
    }
    
    func setNetworkImage(from urlString: String) {
        if let url = URL(string: urlString) {
            leagueImage.sd_setImage(with: url, placeholderImage: UIImage(named: "image-placeholder"))
        } else {
            leagueImage.image = UIImage(named: "image-placeholder")
        }
    }
    
    func setLocalImage(from data: Data?) {
        if let imageData = data, let image = UIImage(data: imageData) {
            leagueImage.image = image
        } else {
            leagueImage.image = UIImage(named: "image-placeholder")
        }
    }
    
    private func updateStarIcon() {
        let starImageName = isFavoriteState ? "star.fill" : "star"
        favButton.setImage(UIImage(systemName: starImageName), for: .normal)
    }
}

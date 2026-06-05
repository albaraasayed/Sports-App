//
//  LeaguesCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 11/12/1447 AH.
//

import UIKit

class LeaguesCell: UITableViewCell {
    
    @IBOutlet weak var favButton: UIButton!
    
    var isFavorite: Bool = false
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var sportNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImage.layer.cornerRadius = leagueImage.frame.width / 2
        leagueImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func didTapFavButton(_ sender: Any) {
        if isFavorite {
            isFavorite = false
            
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            isFavorite = true
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
    }
    
}

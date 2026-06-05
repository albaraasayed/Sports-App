//
//  UpcomingCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 13/12/1447 AH.
//

import UIKit

class UpcomingCell: UICollectionViewCell {

    @IBOutlet weak var greyBackgroundView: UIView!
    
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team2Label: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueRound: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.primary.cgColor
        
    
    }

}

//
//  ResultMatchCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 13/12/1447 AH.
//

import UIKit

class ResultMatchCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team2Result: UILabel!
    @IBOutlet weak var team1Result: UILabel!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    
    @IBOutlet weak var leagueRound: UILabel!
    
    @IBOutlet weak var eventStadium: UILabel!
    @IBOutlet weak var leagueLogo: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor.primary.cgColor
        self.layer.borderWidth = 1
    }

}

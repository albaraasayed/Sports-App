//
//  PlayerCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 15/12/1447 AH.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundPlayerImage: UIView!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var redRectangle: UIView!
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerCountry: UILabel!
    @IBOutlet weak var matchPlayed: UILabel!
    @IBOutlet weak var redCards: UILabel!
    @IBOutlet weak var totalGoals: UILabel!
    @IBOutlet weak var yellowCards: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    private func setupUI() {
        playerImage.layer.cornerRadius = playerImage.frame.height/2
        backgroundPlayerImage.layer.cornerRadius = playerImage.frame.height/2
        backgroundPlayerImage.layer.borderWidth = 3
        backgroundPlayerImage.layer.borderColor = UIColor.Primary.cgColor
        backgroundCardView.layer.borderWidth = 2
        backgroundCardView.layer.borderColor = UIColor.Primary.cgColor
//        backgroundCardView.layer.cornerRadius = 18
        
        redRectangle.transform = CGAffineTransform(rotationAngle: .pi/4)
        redRectangle.isHidden = true
    }

}

//
//  TeamsCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 12/12/1447 AH.
//

import UIKit

class TeamsCell:
    UICollectionViewCell {
    
    @IBOutlet weak var shapeView: UIView!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.layer.borderWidth = 1
        backgroundImage.layer.borderColor = UIColor.primary.cgColor
        
        shapeView.transform = CGAffineTransform(rotationAngle: .pi / 4)
    }

}

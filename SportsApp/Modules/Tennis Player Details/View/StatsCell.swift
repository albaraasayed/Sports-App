//
//  StatsCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import UIKit

class StatsCell: UITableViewCell {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var matchWonLabel: UILabel!
    @IBOutlet weak var matchLostLabel: UILabel!
    
    @IBOutlet weak var hardLostLabel: UILabel!
    @IBOutlet weak var hardWonLabel: UILabel!
    
    @IBOutlet weak var clayLostLabel: UILabel!
    @IBOutlet weak var clayWonLabel: UILabel!
    
    @IBOutlet weak var grassLostLabel: UILabel!
    @IBOutlet weak var grassWonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with stat: TennisStat) {
        seasonLabel.text = stat.season ?? "-"
        typeLabel.text = stat.type ?? "-"
        rankLabel.text = stat.rank ?? "-"
        titleLabel.text = stat.titles ?? "-"
        
        matchWonLabel.text = stat.matchesWon ?? "0"
        matchLostLabel.text = stat.matchesLost ?? "0"
        
        hardWonLabel.text = stat.hardWon ?? "0"
        hardLostLabel.text = stat.hardLost ?? "0"
        
        clayWonLabel.text = stat.clayWon ?? "0"
        clayLostLabel.text = stat.clayLost ?? "0"
        
        grassWonLabel.text = stat.grassWon ?? "0"
        grassLostLabel.text = stat.grassLost ?? "0"
    }
}

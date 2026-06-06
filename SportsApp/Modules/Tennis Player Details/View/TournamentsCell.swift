//
//  TournamentsCell.swift
//  SportsApp
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import UIKit

class TournamentsCell: UITableViewCell {

    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var surfaceLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!
    
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
    
    func configure(with tournament: TennisTournament) {
        tournamentName.text = tournament.name ?? "Tournament Name"
        seasonLabel.text = tournament.season ?? "-"
        typeLabel.text = tournament.type ?? "-"
        surfaceLabel.text = tournament.surface ?? "-"
        prizeLabel.text = tournament.prize ?? "-"
    }
}

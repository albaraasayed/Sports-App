//
//  SectionHeaderView.swift
//  SportsApp
//
//  Created by albaraa alsayed on 13/12/1447 AH.
//
import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .manrope(weight: .medium, size: 18)
        label.textColor = .TextSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: 42)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

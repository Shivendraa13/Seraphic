//
//  OnlineCell.swift
//  Seraphic Design
//
//  Created by Shivendra on 12/12/24.
//

import UIKit

class OnlineCell: UICollectionViewCell {
    
    @IBOutlet weak var advisorImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prePiceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let attributedString = NSAttributedString(
            string: prePiceLabel.text ?? "",
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        prePiceLabel.attributedText = attributedString
    }
    
}

//
//  AdvisiorCell.swift
//  Seraphic Design
//
//  Created by Shivendra on 12/12/24.
//

import UIKit

class AdvisiorCell: UICollectionViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var advisorImage: UIImageView!
    @IBOutlet weak var advisorname: UILabel!
    @IBOutlet weak var prePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let attributedString = NSAttributedString(
            string: prePriceLabel.text ?? "",
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        prePriceLabel.attributedText = attributedString
    }
    
}

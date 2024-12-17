//
//  ReceiveCell.swift
//  Seraphic Design
//
//  Created by Shivendra on 12/12/24.
//

import UIKit

class ReceiveCell: UICollectionViewCell {
    
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupCornerRadius()
    }
    
    private func setupCornerRadius() {
        let path = UIBezierPath(
            roundedRect: sendView.bounds,
            byRoundingCorners: [.topRight, .bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 18, height: 18)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        sendView.layer.mask = mask
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupCornerRadius()
    }
}

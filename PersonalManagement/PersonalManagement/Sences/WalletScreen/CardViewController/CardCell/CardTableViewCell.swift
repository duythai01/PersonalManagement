//
//  CardTableViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 20/07/2023.
//

import UIKit

class CardTableViewCell: UITableViewCell, ReuseCellType {
    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var expiredDateLabel: UILabel!
    @IBOutlet private weak var serialNumberLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var containerShadowView: UIView!
    @IBOutlet private weak var currentBalanceLabel: UILabel!

    let backgroundImages = [UIImage(named: "Terminal"),
                            UIImage(named: "Dusk"),
                            UIImage(named: "Flickr"),
                            UIImage(named: "Ash"),
                            UIImage(named: "Deep Space"),
                            UIImage(named: "Flare"),
                            UIImage(named: "Harvey"),
                            UIImage(named: "Mirage"),
                            UIImage(named: "Monnlit Asteroid"),
                            UIImage(named: "Quepal"),
                            UIImage(named: "Very Blue"),
                            UIImage(named: "Rea"),]

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16
        containerShadowView.layer.cornerRadius = 16
        containerShadowView.applyShadow(alpha: 0.5)
        serialNumberLabel.applyShadow()
    }

    func configView() {
        let backgroundImage = backgroundImages[Int.random(in: 0...backgroundImages.count - 1)]
        background.image = backgroundImage
//        serialNumberLabel.text = serialNumber
//        expiredDateLabel.text = expiredDate
    }
    
}

extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

}

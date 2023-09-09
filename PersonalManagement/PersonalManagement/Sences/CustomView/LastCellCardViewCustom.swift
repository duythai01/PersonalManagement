//
//  LastCellCardViewCustom.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/09/2023.
//

import Foundation
import UIKit

class LastCellViewCustom: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Create a new UIBezierPath
        let path = UIBezierPath()

        // Point match
        let pointTopLeft = CGPoint(x: rect.minX, y: rect.minY)
        let pointTopMidYMarginRight40 = CGPoint(x: rect.midX - 40, y: rect.minY)
        let pointTopMidY40 = CGPoint(x: rect.midX, y: rect.minY + 40)
        let pointTopMidYMarginLeft40 = CGPoint(x: rect.midX + 40, y: rect.minY)
        let pointTopRight = CGPoint(x: rect.maxX, y: rect.minY)
        let pointBottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let pointBottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        path.move(to: pointTopLeft)

        path.addLine(to: pointTopMidYMarginRight40)
        path.addQuadCurve(to: pointTopMidYMarginLeft40, controlPoint: pointTopMidY40)
        path.addLine(to: pointTopRight)
        path.addLine(to: pointBottomRight)
        path.addLine(to: pointBottomLeft)

        path.close()

        // Set the fill color
        UIColor.white.setFill()
        path.fill()


       /// Draw line top color
        let topLinePath = UIBezierPath()
        topLinePath.move(to: CGPoint(x: rect.minX + 2, y: rect.minY))
        topLinePath.addLine(to: pointTopMidYMarginRight40)
        topLinePath.addQuadCurve(to: pointTopMidYMarginLeft40, controlPoint: pointTopMidY40)
        topLinePath.addLine(to: CGPoint(x: rect.maxX - 2, y: rect.minY))

        UIColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2794952044)).setStroke()
        topLinePath.lineWidth = 2.0
        topLinePath.stroke()
    }


    
}

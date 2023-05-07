//
//  BalanceTableViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 10/05/2023.
//

import UIKit

final class BalanceTableViewCell: UITableViewCell, ReuseCellType {

    @IBOutlet private weak var outcomeMoneyLabel: UILabel!
    @IBOutlet private weak var outcomePercentLabel: UILabel!
    @IBOutlet private weak var outcomePercentContainerView: customShadowView!
    @IBOutlet private weak var incomeMoneyLabel: UILabel!
    @IBOutlet private weak var incomePercentLabel: UILabel!
    @IBOutlet private weak var incomePercentContainerView: customShadowView!
    @IBOutlet private weak var outcomeContainerView: UIView!
    @IBOutlet private weak var incomeContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        congfigView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }


    override func didMoveToSuperview() {
            super.didMoveToSuperview()
            if superview != nil {
                animateNumberCount(from: 0.00, to: 300.00, duration: 2)

            }
        }

//    func animateNumberCount( incomeValue: Float, outcomeValue: Float, duration: TimeInterval) {
//        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
//            self.incomeMoneyLabel.text = "\(incomeValue)$"
//            self.outcomeMoneyLabel.text = "\(outcomeValue)$"
//
//        }
//        let check: Bool =  incomeValue < outcomeValue
//
//            animator.addAnimations({
//                self.incomeMoneyLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//            }, delayFactor: 0.2)
//            animator.addAnimations({
//                self.outcomeMoneyLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//            }, delayFactor: 0.2)
//
//        animator.addCompletion { (_) in
//            self.incomeMoneyLabel.transform = .identity
//            self.outcomeMoneyLabel.transform = .identity
//        }
//
//        animator.startAnimation(afterDelay: 0.5)
//
//        let timeInterval = duration / TimeInterval((check ? outcomeValue : incomeValue))
//
//        for i in stride(from: 0,
//                        through: check ? outcomeValue : incomeValue,
//                        by: 0.01) {
//            print(i)
//            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval * TimeInterval(i)) {
//                if i <= (check ? incomeValue : outcomeValue) {
//                    (check ? self.incomeMoneyLabel : self.outcomeMoneyLabel).text  = "\(String(format: "%.2f", i))$"
//                } else {
//                    (!check ? self.incomeMoneyLabel : self.outcomeMoneyLabel).text  = "\(String(format: "%.2f", i))$"
//                }
//            }
//        }
//
//    }


    func animateNumberCount(from startValue: Float, to endValue: Float, duration: TimeInterval) {
           let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
               self.incomeMoneyLabel.text = "\(startValue)$"
           }

           animator.addAnimations({
               self.incomeMoneyLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
           }, delayFactor: 0.2)

           animator.addCompletion { (_) in
               self.incomeMoneyLabel.transform = .identity
           }

           animator.startAnimation(afterDelay: 0.5)

           let valueRange = endValue - startValue
           let timeInterval = duration / TimeInterval(valueRange)

        for i in stride(from: startValue, through: endValue, by: 0.01) {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval * TimeInterval(i - startValue)) {
                self.incomeMoneyLabel.text = "\(String(format: "%.2f", i))$"
            }
        }
       }

    private func congfigView() {
        layer.cornerRadius = CornerRadiousType.cell.value

        outcomePercentContainerView.layer.cornerRadius = outcomePercentContainerView.frame.size.height / 2
        incomePercentContainerView.layer.cornerRadius = incomePercentContainerView.frame.size.height / 2

        incomeContainerView.do {
            $0.layer.cornerRadius = 12
            $0.applyShadow()

        }

        outcomeContainerView.do {
            $0.layer.cornerRadius = 12
            $0.applyShadow()
        }


    }

    
}


final class customShadowView: UIView {
    private var shadowLayer: CAShapeLayer!

       override func layoutSubviews() {
           super.layoutSubviews()

           if shadowLayer == nil {
               shadowLayer = CAShapeLayer()
               shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
               shadowLayer.fillColor = UIColor.white.cgColor

               shadowLayer.shadowColor = UIColor.darkGray.cgColor
               shadowLayer.shadowPath = shadowLayer.path
               shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
               shadowLayer.shadowOpacity = 0.8
               shadowLayer.shadowRadius = 2

               layer.insertSublayer(shadowLayer, at: 0)
               //layer.insertSublayer(shadowLayer, below: nil) // also works
           }
       }
}

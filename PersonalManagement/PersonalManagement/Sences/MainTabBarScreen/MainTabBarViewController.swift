//
//  MainViewController.swift
//  FlixHqMovie
//
//  Created by DuyThai on 08/05/2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
     var shouldSelectOnTabBar = true
    private var circleView : UIView!
    private var circleImageView: UIImageView!
    override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar, let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? SHCircleBar, let index = viewControllers?.firstIndex(of: newValue) else {return}
            tabBar.select(itemAt: index, animated: true)
        }
    }

     override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? SHCircleBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: true)
        }
    }

     override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = SHCircleBar()
        self.setValue(tabBar, forKey: "tabBar")
        self.circleView = UIView(frame: .zero)
        circleView.layer.cornerRadius = 30
        circleView.backgroundColor = .tabBarTintColor
        circleView.isUserInteractionEnabled = false

        self.circleImageView = UIImageView(frame: .zero)
        circleImageView.layer.cornerRadius = 30
        circleImageView.isUserInteractionEnabled = false
        circleImageView.contentMode = .center

        circleView.addSubview(circleImageView)
        self.view.addSubview(circleView)
        let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items?.count ?? 4)

        circleView.frame = CGRect(x: tabWidth / 2 - 30, y: self.tabBar.frame.origin.y - 40, width: 60, height: 60)
        circleImageView.frame = self.circleView.bounds

         tabBar.tintColor = UIColor.clear

    }
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleImageView.image = image(with: self.tabBar.selectedItem?.image ?? self.tabBar.items?.first?.image, scaledTo: CGSize(width: 30, height: 30))
         if let centerViewController = viewControllers?[2] {
             selectedViewController = centerViewController
             selectedIndex = 2
              let idx = 2
                 shouldSelectOnTabBar = false
                 selectedIndex = 2
                 let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items!.count)
                 UIView.animate(withDuration: 0.3) {
                     self.circleView.frame = CGRect(x: (tabWidth * CGFloat(idx) + tabWidth / 2 - 30), y: self.tabBar.frame.origin.y - 45 , width: 60, height: 60)
                 }
                 UIView.animate(withDuration: 0.15, animations: {
                     self.circleImageView.alpha = 0
                 }) { (_) in
                     self.circleImageView.image = self.image(with: self.tabBar.items?[2].image, scaledTo: CGSize(width: 30, height: 30))
                     UIView.animate(withDuration: 0.15, animations: {
                         self.circleImageView.alpha = 1
                     })
                 }
                 delegate?.tabBarController?(self, didSelect: centerViewController)
//             }

         }
    }

    private var _barHeight: CGFloat = 74
    var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else {
                return _barHeight
            }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }

    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }

     override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

     override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }

     override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
         guard let idx = tabBar.items?.firstIndex(of: item) else { return }
        if idx != selectedIndex, let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items!.count)
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame = CGRect(x: (tabWidth * CGFloat(idx) + tabWidth / 2 - 30), y: self.tabBar.frame.origin.y - 15, width: 60, height: 60)
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.circleImageView.alpha = 0
            }) { (_) in
                self.circleImageView.image = self.image(with: item.image, scaledTo: CGSize(width: 30, height: 30))
                UIView.animate(withDuration: 0.15, animations: {
                    self.circleImageView.alpha = 1
                })
            }
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
    private func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, _: false, _: 0.0)
        image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }


}
class SHCircleBar: UITabBar {
    var tabWidth: CGFloat = 0
    var index: CGFloat = 0 {
        willSet{
            self.previousIndex = index
        }
    }
    private var animated = false
    private var selectedImage: UIImage?
    private var previousIndex: CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()

    }
    override func draw(_ rect: CGRect) {
        let fillColor: UIColor = .tabBarTintColor
        tabWidth = self.bounds.width / CGFloat(self.items!.count)
        let bezPath = drawPath(for: index)

        bezPath.close()
        fillColor.setFill()
        bezPath.fill()
        let mask = CAShapeLayer()
        mask.fillRule = .evenOdd
        mask.fillColor = UIColor.white.cgColor
        mask.path = bezPath.cgPath
        if (self.animated) {
            let bezAnimation = CABasicAnimation(keyPath: "path")
            let bezPathFrom = drawPath(for: previousIndex)
            bezAnimation.toValue = bezPath.cgPath
            bezAnimation.fromValue = bezPathFrom.cgPath
            bezAnimation.duration = 0.3
            bezAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            mask.add(bezAnimation, forKey: nil)
        }
        self.layer.mask = mask

    }

    func select(itemAt: Int, animated: Bool) {
        self.index = CGFloat(itemAt)
        self.animated = animated
        self.selectedImage = self.selectedItem?.selectedImage
        self.selectedItem?.selectedImage = nil
        self.setNeedsDisplay()
    }

    func customInit(){
        self.tintColor = .white
        self.barTintColor = .clear
        self.backgroundColor = .clear
    }
    private func drawPath(for index: CGFloat) -> UIBezierPath {
        let bezPath = UIBezierPath()

        let firstPoint = CGPoint(x: (index * tabWidth) - 25, y: 0)
        let firstPointFirstCurve = CGPoint(x: ((tabWidth * index) + tabWidth / 4), y: 0)
        let firstPointSecondCurve = CGPoint(x: ((index * tabWidth) - 25) + tabWidth / 8, y: 52)

        let middlePoint = CGPoint(x: (tabWidth * index) + tabWidth / 2, y: 55)
        let middlePointFirstCurve = CGPoint(x: (((tabWidth * index) + tabWidth) - tabWidth / 8) + 25, y: 52)
        let middlePointSecondCurve = CGPoint(x: (((tabWidth * index) + tabWidth) - tabWidth / 4), y: 0)

        let lastPoint = CGPoint(x: (tabWidth * index) + tabWidth + 25, y: 0)
        bezPath.move(to: firstPoint)
        bezPath.addCurve(to: middlePoint, controlPoint1: firstPointFirstCurve, controlPoint2: firstPointSecondCurve)
        bezPath.addCurve(to: lastPoint, controlPoint1: middlePointFirstCurve, controlPoint2: middlePointSecondCurve)
        bezPath.append(UIBezierPath(rect: self.bounds))
        return bezPath
    }


}

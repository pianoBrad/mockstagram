//
//  HeartTabSegmentedControl.swift
//  mockstagram
//
//  Created by Brad Phillips on 3/30/19.
//  Copyright © 2019 megaBreezy. All rights reserved.
//

import UIKit

class HeartTabSegmentedControl: UISegmentedControl
{
    private var items : [String] = ["Following", "You"]
    private var selectedLineView = UIView()
    private var leftConst : NSLayoutConstraint!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit()
    {
        let tab_font = UIFont(name: theme.fontNamePrimaryBold, size: 18)
            ?? UIFont.systemFont(ofSize: 18, weight: .bold)
        
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitleTextAttributes([
            NSAttributedString.Key.font : tab_font,
            NSAttributedString.Key.foregroundColor : UIColor.gray
            ], for: .normal)
        self.setTitleTextAttributes([
            NSAttributedString.Key.font : tab_font,
            NSAttributedString.Key.foregroundColor : UIColor.black
            ], for: .selected)
        
        for (index, item) in items.enumerated()
        {
            self.insertSegment(withTitle: item, at: index, animated: false)
        }
        self.selectedSegmentIndex = (items.count > 0)
            ? items.count.advanced(by: -1)
            : 0
    
        setupSelectedLineConstraints()
    }
    
    private func setupSelectedLineConstraints()
    {
        let lineHeight : CGFloat = 2
        
        self.selectedLineView.removeFromSuperview()
        self.selectedLineView.translatesAutoresizingMaskIntoConstraints = false
        self.selectedLineView.backgroundColor = .black
        
        self.addSubview(self.selectedLineView)
        
        let widthConst = NSLayoutConstraint(
            item: selectedLineView, attribute: .width,
            relatedBy: .equal, toItem: self, attribute: .width,
            multiplier: 1 / CGFloat(self.numberOfSegments), constant: 0)
        let heightConst = NSLayoutConstraint(
            item: selectedLineView, attribute: .height,
            relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,
            multiplier: 1, constant: lineHeight)
        let topConst = NSLayoutConstraint(
            item: selectedLineView, attribute: .top,
            relatedBy: .equal, toItem: self, attribute: .bottom,
            multiplier: 1, constant: -(lineHeight - 1))
        leftConst = NSLayoutConstraint(
            item: selectedLineView, attribute: .left, relatedBy: .equal,
            toItem: self, attribute: .left,
            multiplier: 1, constant: 0)
        
        self.addConstraints([widthConst, heightConst, topConst, leftConst])
        self.layoutIfNeeded()
        
        underlineSelectedSegment()
    }
    
    override func didChangeValue(forKey key: String)
    {
        underlineSelectedSegment(animate: true)
    }
    
    public func underlineSelectedSegment(animate : Bool = false)
    {
        guard leftConst != nil else { return }
     
        let duration = (animate) ? 0.3 : 0
        let selected_index = CGFloat(self.selectedSegmentIndex)
        
        leftConst.constant = self.selectedLineView.frame.width * selected_index
        
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()
        })
    }
}

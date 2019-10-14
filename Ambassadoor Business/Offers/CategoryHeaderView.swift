//
//  CategoryHeaderView.swift
//  Ambassadoor Business
//
//  Created by K Saravana Kumar on 07/08/19.
//  Copyright © 2019 Tesseract Freelance, LLC. All rights reserved.
//

import UIKit
protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    var imageView: UIImageView?
    var bottomImage: UIImageView?
    var expandBool: Bool = false
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.backgroundColor = UIColor.white
        self.backgroundView?.backgroundColor = UIColor.white
        self.superview?.backgroundColor = UIColor.white
        //        self.contentView.backgroundColor = UIColor(red: 0.0, green: 11.0/255.0, blue: 24.0/255.0, alpha: 1.0)
        
        self.contentView.backgroundColor = UIColor.white
        
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageName = "arrowDownExpand"
        _ = UIImage(named: imageName)
        imageView = UIImageView()
        //imageView = UIImageView(image: image!)
        if expandBool {
            let imageName = "arrowUp"
            let image = UIImage(named: imageName)
            imageView = UIImageView(image: image!)
            imageView?.frame = CGRect(x: self.contentView.frame.width-40, y: 20, width: 30, height: 26)
        }
        else {
            let imageName = "arrowDownExpand"
            let image = UIImage(named: imageName)
            imageView = UIImageView(image: image!)
            imageView?.frame = CGRect(x: self.contentView.frame.width-40, y: 20, width: 30, height: 26)
        }
        
        imageView?.backgroundColor = UIColor.white
        //imageView?.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView!)
        
        bottomImage = UIImageView()
        bottomImage?.frame = CGRect(x: 0, y: self.contentView.frame.height-1, width: self.contentView.frame.width, height: 1)
        bottomImage?.alpha = 1.0
        bottomImage?.backgroundColor = UIColor.white
        self.contentView.addSubview(bottomImage!)
        
        
        self.textLabel?.textColor = UIColor.black
        self.textLabel?.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        //self.backgroundView?.backgroundColor = UIColor.clear
        self.backgroundView?.backgroundColor = UIColor(red: 0, green: 25.0/255.0, blue: 39.0/255.0, alpha: 0.5)
        //UIColor(red: 24.0/255.0, green: 129.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        // UIColor(red: 0, green: 25.0/255.0, blue: 39.0/255.0, alpha: 0.5) - light black
        //self.superview?.backgroundColor = UIColor.clear
        //self.contentView.backgroundColor = UIColor.clear
    }
    
    
}

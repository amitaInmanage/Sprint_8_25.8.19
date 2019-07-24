//
//  CustomProgressView.swift
//  Maccabi_Haifa
//
//  Created by Aviv Frenkel on 09/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class CustomProgressView: UIView {
    
    
    var contentView : UIView!

   
    @IBOutlet weak var imgProgressView: UIImageView!
    //    @IBOutlet weak var imgProgressView: UIProgressView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        configureXibViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        configureXibViews()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func configureXibViews(){
        if #available(iOS 10.0, *) {
//            self.imgProgressView.progressImage = UIImage(named: "progress-bar")
//            self.imgProgressView.transform = CGAffineTransform(scaleX: -1, y: -1);
//            self.imgProgressView.trackTintColor = .clear
        } else {
            // Fallback on earlier versions
        }
        self.imgProgressView.layer.cornerRadius = 6
        self.imgProgressView.clipsToBounds = true
     




    }
    

}

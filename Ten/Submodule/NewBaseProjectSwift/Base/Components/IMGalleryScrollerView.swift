//
//  IMGalleryScrollerView.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 12/09/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

@objc protocol IMGalleryScrollerViewDelegate: class,NSObjectProtocol {
 
    func viewForIndex(index: Int, frame: CGRect) -> UIView
}

class IMGalleryScrollerView: UIView,UIScrollViewDelegate {

    weak var delegate: IMGalleryScrollerViewDelegate!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pager: UIPageControl?
    
    var reverse = false
    private var timer : Timer?
    
    private var numberOfItems = 0
    
    private var timerTimeInterval = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.scrollView.isPagingEnabled = true
        
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.scrollsToTop = false
        self.scrollView.delegate = self
        
    }

    func setGallery(arrGallery: Array<Any>, frame: CGRect, isRTL: Bool, pagerFrame: CGRect, timerTimeInterval: Int, galleryDelegate: IMGalleryScrollerViewDelegate) {
        setGallery(arrGallery: arrGallery, frame: frame, isRTL: isRTL, page: 0, pagerFrame: pagerFrame,timerTimeInterval: timerTimeInterval, galleryDelegate: galleryDelegate)
    }
    
    func setGallery(arrGallery: Array<Any>, frame: CGRect, isRTL: Bool, pagerFrame: CGRect, galleryDelegate: IMGalleryScrollerViewDelegate) {
        setGallery(arrGallery: arrGallery, frame: frame, isRTL: isRTL, page: 0, pagerFrame: pagerFrame,timerTimeInterval: 0, galleryDelegate: galleryDelegate)
    }
    
    func setGallery(arrGallery: Array<Any>, frame: CGRect, isRTL: Bool, page: Int, pagerFrame: CGRect, timerTimeInterval: Int, galleryDelegate: IMGalleryScrollerViewDelegate) {
        
        self.delegate = galleryDelegate
        self.scrollView.frame = frame
        self.timerTimeInterval = timerTimeInterval
        
        numberOfItems = arrGallery.count
        
        let width = Int(frame.width) * Int(arrGallery.count)
        
        self.scrollView.contentSize = CGSize(width: CGFloat(width), height: frame.height)
        
        //self.pager?.backgroundColor = arrGallery.count > 1 ? UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5): UIColor.clear
        
        self.pager?.numberOfPages = arrGallery.count
        self.pager?.currentPage = self.pager?.currentPage ?? page
        self.pager?.hidesForSinglePage = true
        
        self.pager?.isEnabled = false
        
       // self.pager?.frame = CGRect(x: pagerFrame.origin.x, y: pagerFrame.origin.y, width: frame.width, height: frame.height)
        
        if isRTL {
            self.pager?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        
        self.scrollView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        for i in 0..<arrGallery.count {
            
            var objFrame = frame
            objFrame.origin.x = frame.width * CGFloat(i)

            if let aDelegate = self.delegate {

                let objVw = aDelegate.viewForIndex(index: i, frame: objFrame)
                
                if isRTL {
                    objVw.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                }
                
                self.scrollView.addSubview(objVw)

            }
            
        }
    
        if isRTL {
            self.scrollView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        
        initTimerForScrolling()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.width()
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        self.pager?.currentPage = Int(page)
        
        timer?.invalidate()
        timer = nil
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.width()
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        self.pager?.currentPage = Int(page)

    }
    
    func initTimerForScrolling() {
        
        timer?.invalidate()
        timer = nil

        if numberOfItems > 1 {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timerTimeInterval), target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)

        }
        
    }

    @objc func moveToNextIndex() {
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        
        if let currentPage = self.pager?.currentPage {
            
            var nextPage = currentPage
            
            if currentPage == numberOfItems - 1 || (currentPage > 0 && reverse) {
                reverse = true
                nextPage -= 1
            }
            else{
                reverse = false
                nextPage += 1
            }
            
            let slideToX = CGFloat(nextPage) * pageWidth
            
            self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        }

    }

    
}

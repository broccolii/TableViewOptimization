//
//  MainTableViewController.swift
//  TableViewLazyLoad
//
//  Created by Broccoli on 15/12/17.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

/// http://tech.glowing.com/cn/practice-in-uiscrollview/

import UIKit
import SDWebImage

class MainTableViewController: UITableViewController {
    
    var targetRect: NSValue!
    
    lazy var tableViewDataArr = [
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2296353495.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2296353501.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2295441865.jpg")!,
        NSURL(string: "http://img4.douban.com/view/photo/photo/public/p2295007187.jpg")!,
        NSURL(string: "http://img4.douban.com/view/photo/photo/public/p2294256416.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2294179835.jpg")!,
        NSURL(string: "http://img4.douban.com/view/photo/photo/public/p2293804008.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292972875.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292613994.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2291384961.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2294179835.jpg")!,
        NSURL(string: "http://img4.douban.com/view/photo/photo/public/p2293804008.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292972875.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292613994.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2291384961.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2294179835.jpg")!,
        NSURL(string: "http://img4.douban.com/view/photo/photo/public/p2293804008.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292972875.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292613994.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292972875.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292613994.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2291384961.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2294179835.jpg")!,
        NSURL(string: "http://img4.douban.com/view/photo/photo/public/p2293804008.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292972875.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292613994.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292382693.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2292064215.jpg")!,
        NSURL(string: "http://img3.douban.com/view/photo/photo/public/p2291384961.jpg")!]
}

extension MainTableViewController {
    func setupCell(cell: MainTableViewCell, atIndexPath indexPath: NSIndexPath) {
       
        // 判断一下是否是 目标 cell  如果不是的话 进行图片操作
        var imageURL: NSURL? = cell.imgContent.sd_imageURL()
        let currentURL = tableViewDataArr[indexPath.row]
        if imageURL == nil {
            imageURL = NSURL(string: "")
        }
        if !(imageURL!.isEqual(currentURL)) {
            cell.imgContent.alpha = 0.0
            
            let manager = SDWebImageManager.sharedManager()
            let cellFrame = tableView.rectForRowAtIndexPath(indexPath)
            
            var shouldLoadImage = true
            // 目标 cell 在屏幕中显示
            if targetRect != nil && CGRectIntersectsRect(targetRect.CGRectValue(), cellFrame) {
                let cache = manager.imageCache
                let key = manager.cacheKeyForURL(tableViewDataArr[indexPath.row])
                if cache.imageFromMemoryCacheForKey(key) == nil {
                    shouldLoadImage = false
                }
            }
            
            if shouldLoadImage {
                cell.imgContent.sd_setImageWithURL(tableViewDataArr[indexPath.row], placeholderImage: nil, completed: { (image, ErrorType, cacheType, imageURL) -> Void in
                    if imageURL.isEqual(self.tableViewDataArr[indexPath.row]) {
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            cell.imgContent.alpha = 1.0
                        })
                    }
                })
            }
        }
    }
    
    func loadImageForVisibleCells() {
        let visiblesCells = tableView.visibleCells as! [MainTableViewCell]
        for cell in visiblesCells {
            let indexPath = tableView.indexPathForCell(cell)
            setupCell(cell, atIndexPath: indexPath!)
        }
    }
}

// MARK: - table view data source
private let CellIdentifier = "lazyLoadCell"
extension MainTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! MainTableViewCell
        setupCell(cell, atIndexPath: indexPath)
        return cell
    }
}

// scroll view delegate
extension MainTableViewController {
    // 开始滑动
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        targetRect = nil
        loadImageForVisibleCells()
    }
    
    // 将要结束拖拽
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let rect = CGRect(x: targetContentOffset.memory.x, y: targetContentOffset.memory.y, width: scrollView.bounds.width, height: scrollView.bounds.height)
        targetRect = NSValue(CGRect: rect)
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        targetRect = nil
        loadImageForVisibleCells()
    }
}
class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgContent: UIImageView!
    
}

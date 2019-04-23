//
//  ViewController.swift
//  StickySegmented
//
//  Created by Nicolas on 4/23/19.
//  Copyright © 2019 doapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainTableHeight: NSLayoutConstraint!
    
    lazy var segmentedView: SWSegmentedControl = {
        let segmented = SWSegmentedControl()
        segmented.backgroundColor = .white
        segmented.layer.borderColor = UIColor.gray.cgColor
        segmented.layer.borderWidth = 1
        segmented.frame = optionsView.frame
        return segmented
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableHeight.constant = CGFloat(44*20)
        view.addSubview(segmentedView)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        mainScrollView.refreshControl = refreshControl

        mainScrollView.delegate = self
    }
    
    @objc func pullToRefresh(_ notification: UIRefreshControl) {
        notification.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            notification.endRefreshing()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        let segmentViewOffset = headerView.frame.height - segmentedView.frame.height + 50 - offset
        var segmentTransform = CATransform3DIdentity
        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -headerView.frame.maxY), 0)
        segmentedView.layer.transform = segmentTransform
        mainScrollView.scrollIndicatorInsets = UIEdgeInsets(top: segmentedView.frame.maxY, left: 0, bottom: 0, right: 0)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}



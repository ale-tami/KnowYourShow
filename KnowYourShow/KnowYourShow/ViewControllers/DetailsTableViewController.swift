//
//  DetailsTableViewController.swift
//  KnowYourMovie
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsTableViewController: UITableViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var show:Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0, green: 111/255, blue: 255/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Details"
        titleLabel.text = show.name
        if let urlStr = show.imageLargeUrl, let url = URL(string: urlStr) {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: url)
        }
        ratingLabel.text =  "Rate: \(show.rate ?? 0.0)"
        
        var string:NSString = NSString(string: show.summary)
        string = string.appending("<style>body{font-family:'Arial'; font-size:16;}</style>") as NSString
        let htmlData = string.data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedStr = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        overviewTextView.attributedText = attributedStr
        
        if let date = show.premiered {
            let dateo = DateFormatter.formatForReceivingDate.date(from:date)
            let showDate = DateFormatter.formatForShowingDate.string(from: dateo ?? Date())
            releaseDateLabel.text = "Aired: \(showDate)"
        } else {
            releaseDateLabel.text = "Aired date not available"
        }
        
        self.siteLabel.text = show.officialSite ?? "No Official Site available"
        self.siteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSafari)))
        self.siteLabel.isUserInteractionEnabled = true
    }
    
    @objc func openSafari() {
        if let str = show.officialSite, let url = URL(string:str) {
            UIApplication.shared.open(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return  218
        }
        let fixedWidth = overviewTextView.frame.size.width
        let newSize = overviewTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize.height + 50
    }

}

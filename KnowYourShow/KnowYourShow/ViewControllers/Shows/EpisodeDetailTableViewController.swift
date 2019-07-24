//
//  EpisodeDetailTableViewController.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 23/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class EpisodeDetailTableViewController: UITableViewController {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeSummaryTextView: UITextView!
    
    var episode:Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    func setupViews(){
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 44
        
        if let urlStr = self.episode.imageLargeUrl, let url = URL(string: urlStr) {
            self.episodeImageView.kf.indicatorType = .activity
            self.episodeImageView.kf.setImage(with: url)
        }
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0, green: 111/255, blue: 255/255, alpha: 1)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "Ep:\(episode.number) Se:\(episode.season)"
        self.episodeNameLabel.text = episode.name
        var string:NSString = NSString(string: episode.summary)
        string = string.appending("<style>body{font-family:'Arial'; font-size:16;}</style>") as NSString
        let htmlData = string.data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedStr = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        self.episodeSummaryTextView.attributedText = attributedStr
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return  230
        } else if indexPath.row == 1 {
            return UITableView.automaticDimension
        }
        let fixedWidth = episodeSummaryTextView.frame.size.width
        let newSize = episodeSummaryTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize.height + 20
    }
  

}

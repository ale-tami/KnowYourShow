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
    @IBOutlet weak var vcContainer: UIView!
    
    var show:Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupChildVC()
    }

    func setupViews() {
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0, green: 111/255, blue: 255/255, alpha: 1)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "Details"
        self.titleLabel.text = show.name
        if let urlStr = show.imageLargeUrl, let url = URL(string: urlStr) {
            self.posterImageView.kf.indicatorType = .activity
            self.posterImageView.kf.setImage(with: url)
        }
        self.ratingLabel.text =  "Rate: \(show.rate ?? 0.0)"
        
        var string:NSString = NSString(string: show.summary)
        string = string.appending("<style>body{font-family:'Arial'; font-size:16;}</style>") as NSString
        let htmlData = string.data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedStr = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        self.overviewTextView.attributedText = attributedStr
        
        if let date = show.premiered {
            let dateo = DateFormatter.formatForReceivingDate.date(from:date)
            let showDate = DateFormatter.formatForShowingDate.string(from: dateo ?? Date())
            self.releaseDateLabel.text = "Aired: \(showDate)"
        } else {
            self.releaseDateLabel.text = "Aired date not available"
        }
        
        self.siteLabel.text = self.show.officialSite ?? "No Official Site available"
        self.siteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSafari)))
        self.siteLabel.isUserInteractionEnabled = true
    }
    
    func setupChildVC(){
        let vc = SeasonsViewController(nibName: "SeasonsViewController", bundle: nil)
        self.addChild(vc)
        vc.showId = self.show.id
        vc.view.frame = self.vcContainer.bounds
        vc.delegate = self
        self.vcContainer.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @objc func openSafari() {
        if let str = show.officialSite, let url = URL(string:str) {
            UIApplication.shared.open(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return  218
        } else if indexPath.row == 2 {
            if let child = (self.children.first as? SeasonsViewController) {
                 return child.tableView.contentSize.height
            }
           
        }
        let fixedWidth = overviewTextView.frame.size.width
        let newSize = overviewTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize.height + 20
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episode = sender as? Episode else { return }
        if let vc = segue.destination as? EpisodeDetailTableViewController{
            vc.episode = episode
        }
    }
    
}

extension DetailsTableViewController:SeasonsViewControllerDelegate {
    func didFinishLoading() {
        self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
    }
    
    func didSelectEpisode(episode: Episode) {
        self.performSegue(withIdentifier: "toEpisodeDetail", sender: episode)
    }
    
    
}

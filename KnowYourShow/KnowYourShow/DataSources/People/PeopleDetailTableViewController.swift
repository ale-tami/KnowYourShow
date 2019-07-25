//
//  PeopleDetailTableViewController.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 24/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class PeopleDetailTableViewController: UITableViewController {
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dodLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    var person:People!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    func setupViews(){
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 44
        
        if let urlStr = self.person.imageLargeUrl, let url = URL(string: urlStr) {
            self.portraitImageView.kf.indicatorType = .activity
            self.portraitImageView.kf.setImage(with: url)
        }
        
        self.portraitImageView?.layer.cornerRadius = 10
        self.portraitImageView?.layer.masksToBounds = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0, green: 111/255, blue: 255/255, alpha: 1)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "\(self.person.name)"
        self.genderLabel.text = self.person.gender
        
        if let dob = self.person.birthday {
            let date = DateFormatter.formatForReceivingDate.date(from:dob)
            let d = DateFormatter.formatForShowingDate.string(from: date ?? Date())
            self.dobLabel.text = d
        }
        
        if let dod = self.person.deathday {
            let date = DateFormatter.formatForReceivingDate.date(from:dod)
            let d = DateFormatter.formatForShowingDate.string(from: date ?? Date())
            self.dodLabel.text = d
        }
        
        self.urlLabel.text = self.person.url
        self.urlLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSafari)))
        self.urlLabel.isUserInteractionEnabled = true
    }
    
    @objc func openSafari() {
        if let url = URL(string:self.person.url) {
            UIApplication.shared.open(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return  218
        } else if indexPath.row == 1 {
            guard let _ = self.person.birthday else {
                return 0
            }
        } else if indexPath.row == 2 {
            guard let _ = self.person.gender else {
                return 0
            }
        } else if indexPath.row == 3{
            guard let _ = self.person.deathday else {
                return 0
            }
        }
        
        return UITableView.automaticDimension
    }
    
}

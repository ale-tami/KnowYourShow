//
//  ShowsInteractor.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import SVProgressHUD

class ShowsInteractor <Delegate:BaseDelegate> where Delegate.T == [Show]{
    typealias DelegateType = Delegate
    var delegate:DelegateType?
    
    private var page:Int = 0
    private var shows:[Show] = []
    
    //As long as the object lives, the page counter won't be reset
    func getShows() {
        SVProgressHUD.show()
        ShowsService().getAllShows(with: self.page, successHandler: { [unowned self] (shows) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.shows.append(contentsOf: shows)
                self.delegate?.received(objects: self.shows)
                self.page += 1
            }
        }, failureHandler: { [unowned self] (str) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.delegate?.failedToReceiveObjects(errorStr: str)
            }
        })
    }
    
    func getCurrentPaginatedShows() -> [Show]{
        return self.shows
    }
    
    func getShows(with str:String) {
        SVProgressHUD.show()
        ShowsService().getShows(with:str, successHandler: { [unowned self] (shows) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.delegate?.received(objects: shows)
            }
            }, failureHandler: { [unowned self] (str) in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.delegate?.failedToReceiveObjects(errorStr: str)
                }
        })
    }

}

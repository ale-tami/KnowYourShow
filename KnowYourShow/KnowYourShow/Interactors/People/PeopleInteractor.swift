//
//  PeopleInteractor.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 24/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import SVProgressHUD

class PeopleInteractor <Delegate:BaseDelegate> where Delegate.T == [People] {
    typealias DelegateType = Delegate
    var delegate:DelegateType?
    
    func getPeople(with str:String) {
        SVProgressHUD.show()
        PeopleService().getPeople(with:str, successHandler: { [unowned self] (people) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.delegate?.received(objects: people)
            }
            }, failureHandler: { [unowned self] (str) in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.delegate?.failedToReceiveObjects(errorStr: str)
                }
        })
    }
}

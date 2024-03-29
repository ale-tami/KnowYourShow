//
//  EpisodesInteractor.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import SVProgressHUD

class EpisodesInteractor <Delegate:BaseDelegate> where Delegate.T == [[Episode]]{
    typealias DelegateType = Delegate
    var delegate:DelegateType?
    private var episodes:[[Episode]] = []
    
    func getEpisodes(for showId:Int) {
        SVProgressHUD.show()
        EpisodesService().getEpisodes(for: showId, successHandler: { [unowned self] (episodes) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                var arrayOfEpisodes:[[Episode]] = []
                var epiAux:[Episode] = []
                var season = 1
                for epi in episodes {
                    if epi.season == season {
                        epiAux.append(epi)
                    } else {
                        arrayOfEpisodes.append(epiAux)
                        epiAux = []
                        season += 1
                    }
                }
                arrayOfEpisodes.append(epiAux)
                self.delegate?.received(objects: arrayOfEpisodes)
            }
            }, failureHandler: { [unowned self] (str) in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.delegate?.failedToReceiveObjects(errorStr: str)
                }
        })
    }
}

//
//  EpisodesDelegate.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
@available(iOS, unavailable)
protocol EpisodesDelegate {
    func receivedEpisodes(episodes:[[Episode]])
    func failedToReceiveEpisodes(errorStr:String)
}

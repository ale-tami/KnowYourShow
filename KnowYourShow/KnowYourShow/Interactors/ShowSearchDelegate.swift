//
//  ShowSearchDelegate.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//


protocol ShowSearchDelegate {
    func receivedShows(shows:[Show])
    func failedToReceiveShow(errorStr:String)
}

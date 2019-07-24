//
//  BaseDelegate.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 23/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

protocol BaseDelegate {
    associatedtype T
    func received(objects:T)
    func failedToReceiveObjects(errorStr:String)
}

//
//  ServiceContext.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 21/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class ServiceContext: NSObject {
    static let shared = ServiceContext()
    
    let baseUrl:String = "http://api.tvmaze.com" //Usually put in the info.plist
}

//
//  DateFormatter+Extensions.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let formatForReceivingDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()
    
    static let formatForShowingDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df
    }()
}



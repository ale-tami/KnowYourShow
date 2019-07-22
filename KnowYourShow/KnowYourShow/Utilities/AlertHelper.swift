//
//  AlertHelper.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    static func presentErrorAlert(with messsage:String, in vc:UIViewController){
        let alert = UIAlertController(title: "Error", message: messsage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

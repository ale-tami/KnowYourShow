//
//  PeopleService.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 24/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class PeopleService: NSObject {
    func getPeople(with str:String, successHandler: @escaping ([People]) -> Void, failureHandler:@escaping (String)->Void) {
        let str = str.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: ServiceContext.shared.baseUrl +
            "/search/people?q=\(str)") else {
                failureHandler("Could not get URL")
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    guard let jsonAux = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] else {
                        failureHandler("Could not get JSON")
                        return
                    }
                    let json = jsonAux.map({$0["person"]})
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let people = try JSONDecoder().decode([People].self, from: jsonData!)
                    DispatchQueue.main.async {
                        successHandler(people)
                    }
                } catch {
                    failureHandler("Could not get JSON \(error)")
                }
            } else if error != nil {
                failureHandler(error?.localizedDescription ?? "")
            }
            
            }.resume()
    }}

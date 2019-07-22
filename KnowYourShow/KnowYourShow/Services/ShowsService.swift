//
//  ShowsService.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 21/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class ShowsService: NSObject {
    
    func getAllShows(with page:Int, successHandler: @escaping ([Show]) -> Void, failureHandler:@escaping (String)->Void) {
        guard let url = URL(string: ServiceContext.shared.baseUrl +
            "/shows?page=\(page)") else {
                failureHandler("Could not get URL")
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] else {
                        failureHandler("Could not get JSON")
                        return
                    }
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let shows = try JSONDecoder().decode([Show].self, from: jsonData!)
                    DispatchQueue.main.async {
                        successHandler(shows)
                    }
                } catch {
                    failureHandler("Could not get JSON \(error)")
                }
            }
            
        }.resume()
    }
    
    func getShows(with str:String, successHandler: @escaping ([Show]) -> Void, failureHandler:@escaping (String)->Void) {
        guard let url = URL(string: ServiceContext.shared.baseUrl +
            "/shows?q=\(str)") else {
                failureHandler("Could not get URL")
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] else {
                        failureHandler("Could not get JSON")
                        return
                    }
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let shows = try JSONDecoder().decode([Show].self, from: jsonData!)
                    DispatchQueue.main.async {
                        successHandler(shows)
                    }
                } catch {
                    failureHandler("Could not get JSON \(error)")
                }
            }
            
            }.resume()
    }
}

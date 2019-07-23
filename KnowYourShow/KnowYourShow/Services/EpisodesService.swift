//
//  EpisodesService.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 23/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class EpisodesService: NSObject {
    func getEpisodes(for showId:Int, successHandler: @escaping ([Episode]) -> Void, failureHandler:@escaping (String)->Void) {
        guard let url = URL(string: ServiceContext.shared.baseUrl +
            "/shows/\(showId)/episodes") else {
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
                    let episodes = try JSONDecoder().decode([Episode].self, from: jsonData!)
                    DispatchQueue.main.async {
                        successHandler(episodes)
                    }
                } catch {
                    failureHandler("Could not get JSON \(error)")
                }
            } else if error != nil {
                failureHandler(error?.localizedDescription ?? "")
            }
            
            }.resume()
    }
}

//
//  Episode.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

struct Episode: Codable {
    var id:Int
    var url:String
    var name:String
    var runtime:Int
    var season:Int
    var number:Int
    var airDate:String?
    var airTime:String?
    var summary:String
    var imageMediumUrl:String?
    var imageLargeUrl:String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case runtime
        case season
        case number
        case airdate
        case airtime
        case summary
        case imageMediumUrl
        case imageLargeUrl
        case image
    }
    
    enum ImageKeys:String, CodingKey {
        case medium
        case original
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:
            CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
        name = try container.decode(String.self, forKey: .name)
        runtime = try container.decode(Int.self, forKey: .runtime)
        airDate = try container.decodeIfPresent(String.self, forKey: .airdate)
        airTime = try container.decodeIfPresent(String.self, forKey: .airtime)
        summary = try container.decode(String.self, forKey: .summary)
        season = try container.decode(Int.self, forKey: .season)
        number = try container.decode(Int.self, forKey: .number)
        
        let imageContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageLargeUrl = try imageContainer.decodeIfPresent(String.self, forKey: .original)
        imageMediumUrl = try imageContainer.decodeIfPresent(String.self, forKey: .medium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:
            CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(name, forKey: .name)
        try container.encode(season, forKey: .season)
        try container.encode(number, forKey: .number)
        try container.encode(runtime, forKey: .runtime)
        try container.encodeIfPresent(airDate, forKey: .airdate)
        try container.encodeIfPresent(airTime, forKey: .airtime)
        try container.encode(summary, forKey: .summary)
        
        var imageContainer = container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        try imageContainer.encodeIfPresent(imageLargeUrl, forKey: .original)
        try imageContainer.encodeIfPresent(imageMediumUrl, forKey: .medium)

    }
}

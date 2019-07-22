//
//  Show.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 21/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

struct Show: Codable {
    var id:Int
    var url:String
    var name:String
    var genres:[String]
    var runtime:Int
    var premiered:String?
    var officialSite:String?
    var summary:String
    var imageMediumUrl:String?
    var imageLargeUrl:String?
    var rate:Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case genres
        case runtime
        case premiered
        case officialSite
        case summary
        case rating
        case image
    }
    
    enum RatinKeys: String, CodingKey {
        case average
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
        genres = try container.decode([String].self, forKey: .genres)
        runtime = try container.decode(Int.self, forKey: .runtime)
        premiered = try container.decodeIfPresent(String.self, forKey: .premiered)
        officialSite = try container.decodeIfPresent(String.self, forKey: .officialSite)
        summary = try container.decode(String.self, forKey: .summary)
        
        let imageContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageLargeUrl = try imageContainer.decodeIfPresent(String.self, forKey: .original)
        imageMediumUrl = try imageContainer.decodeIfPresent(String.self, forKey: .medium)
        
        let rateContainer = try container.nestedContainer(keyedBy: RatinKeys.self, forKey: .rating)
        rate = try rateContainer.decodeIfPresent(Float.self, forKey: .average)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:
            CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(name, forKey: .name)
        try container.encode(genres, forKey: .genres)
        try container.encode(runtime, forKey: .runtime)
        try container.encodeIfPresent(premiered, forKey: .premiered)
        try container.encodeIfPresent(officialSite, forKey: .officialSite)
        try container.encode(summary, forKey: .summary)
        
        var imageContainer = container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        try imageContainer.encodeIfPresent(imageLargeUrl, forKey: .original)
        try imageContainer.encodeIfPresent(imageMediumUrl, forKey: .medium)
        
        var rateContainer = container.nestedContainer(keyedBy: RatinKeys.self, forKey: .rating)
        try rateContainer.encodeIfPresent(rate, forKey: .average)
    }
}

//
//  People.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 24/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//


struct People: Codable {
    var id: Int
    var url: String
    var name: String
    var country: String?
    var birthday: String?
    var deathday: String?
    var gender: String?
    var imageMediumUrl:String?
    var imageLargeUrl:String?
    var image:[String:String]?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case country
        case birthday
        case deathday
        case gender
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:
            CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
        name = try container.decode(String.self, forKey: .name)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        deathday = try container.decodeIfPresent(String.self, forKey: .deathday)
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
        image = try container.decodeIfPresent([String:String].self, forKey: .image)
        if let img = image {
            imageMediumUrl = img["medium"]
            imageLargeUrl = img["original"]
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:
            CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(birthday, forKey: .birthday)
        try container.encodeIfPresent(deathday, forKey: .deathday)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(image, forKey: .image)
        
    }
}




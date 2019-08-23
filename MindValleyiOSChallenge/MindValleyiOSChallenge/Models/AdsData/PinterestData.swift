//
//  PinterestData.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 20/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import Foundation

//struct PinterestBase: Codable{
//
//    var data: [PinterestData]?
//    var success: Bool?
//    var code: Int?
//    var message: [String]?
//}

struct PinterestData: Codable {
    
    var id : String?
    var created_at : String?
    var width : Int?
    var height : Int?
    var color : String?
    var likes : Int?
    var liked_by_user : Bool?
    
    var user : UserData?
    var current_user_collections : [String]?
    var urls : UrlsData?
    var categories : [CategoriesData]?
    var links : LinksData?
}

struct UserData: Codable {
    
    var id : String?
    var username : String?
    var name : String?
    var profile_image : ProfileImageData?
    var links : UserLinkData?
}

struct ProfileImageData: Codable {
    
    var small : String?
    var medium : String?
    var large : String?
}

struct UserLinkData: Codable {
    
    var me : String?
    var html : String?
    var photos : String?
    var likes : String?
    
    enum codingKeys: String, CodingKey {
        case me = "self" // because self is a swift keyword
    }
}

struct UrlsData: Codable {
    
    var raw : String?
    var full : String?
    var regular : String?
    var small : String?
    var thumb : String?
}

struct CategoriesData: Codable {
    
    var id : Int?
    var title : String?
    var photo_count : Int?
    var links : CategoriesLinkData?
}

struct CategoriesLinkData: Codable {
    
    var me : String?
    var photos : String?
    
    enum codingKeys: String, CodingKey {
        case me = "self" // because self is a swift keyword
    }
}

struct LinksData: Codable {
    
    var me : String?
    var html : String?
    var download : String?
    
    enum codingKeys: String, CodingKey {
        case me = "self" // because self is a swift keyword
    }
}


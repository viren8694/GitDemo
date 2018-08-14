//
//  FoodModel.swift
//  APIFourSquare
//
//  Created by Viren Patel on 3/19/18.
//  Copyright © 2018 Viren Patel. All rights reserved.
//

import Foundation

struct jsondata: Codable
{
    var response: response
}
struct response: Codable
{
    var venues: [venues]
}
struct venues: Codable
{
    var name: String?
    var location: location
}
struct location: Codable
{
    var lat: Double?
    var lng: Double?
}


//
//  MenuItem.swift
//  Restaurant
//
//  Created by Simo Särkkä on 8.2.2024.
//

import Foundation

struct MenuItem: Decodable {
    let title:String
//    let description:String
    let price:String
    let image:String
    let category:String
}

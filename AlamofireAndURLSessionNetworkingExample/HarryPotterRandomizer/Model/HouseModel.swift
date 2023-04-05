//
//  HouseModel.swift
//  HarryPotterRandomizer
//
//  Created by Arman Myrzakanurov on 22.05.2022.
//

import Foundation

struct HouseModel: Decodable {
    let name: String
    let animal: String
    let element: String
    let founder: String
    let houseColours: String
}

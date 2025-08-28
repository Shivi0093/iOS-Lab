//
//  RoomTypemodal.swift
//  HotelCodable
//
//  Created by Student on 27/08/25.
//

import Foundation
struct RoomType: Equatable{
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
   static func ==(lhs: RoomType,rhs: RoomType)->Bool{
        return lhs.id==rhs.id
    }
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "King Bed", shortName: "Kings", price: 8888),
            RoomType(id: 1, name: "Queen Bed", shortName: "Queens", price: 5555),
            RoomType(id: 2, name: "Penthouse", shortName: "Pent", price: 35000),
            RoomType(id: 3, name: "Single Room", shortName: "Single", price: 3000),
            RoomType(id: 4, name: "Double Room", shortName: "Double", price: 4500),
            RoomType(id: 5, name: "Suite", shortName: "Suite", price: 9999),
            RoomType(id: 6, name: "Deluxe Suite", shortName: "Deluxe", price: 12000),
            RoomType(id: 7, name: "Executive Suite", shortName: "Exec", price: 15000),
            RoomType(id: 8, name: "Presidential Suite", shortName: "Pres", price: 20000)
        ]
    }
}

//
//  RestaurantMapper.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation
import presenter
import SwiftyJSON

public class PlacesRestaurantMapper:IDataMapper<[ModelRestaurant]>{
    
    public override func map(data: Data) throws -> [ModelRestaurant] {
        let json = try JSON(data: data)
        var ret = [ModelRestaurant]()
        for element in json["candidates"].arrayValue {
            ret.append(serialize(json: element))
        }
        return ret
    }
    
    private func serialize(json:JSON) -> ModelRestaurant {
        return ModelRestaurant(iconRef:json["photos"][0]["photo_reference"].stringValue, name: json["name"].stringValue, formattedAddress: json["formatted_address"].stringValue, price: json["price"].stringValue, score: json["rating"].doubleValue, numReviews: json["user_ratings_total"].int32Value, lat: json["geometry"]["location"]["lat"].doubleValue, lng: json["geometry"]["location"]["lng"].doubleValue)
    }
    
}

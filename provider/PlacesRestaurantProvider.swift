//
//  RestaurantProvider.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation
import presenter

public class PlacesRestaurantProvider: IRestaurantProvider {
    private var listeners = [IRestaurantProviderListener]()
    private let restManager:IRestManager
    private let mapper:IDataMapper<[ModelRestaurant]>
    private let apiKey:String
    
    public init(restManager:IRestManager, mapper:IDataMapper<[ModelRestaurant]>,  apiKey:String){
        self.restManager = restManager
        self.mapper = mapper
        self.apiKey = apiKey
    }
    
    public func addListener(restListener: IRestaurantProviderListener) {
        listeners.append(restListener)
    }
    
    public func removeListener(restListener: IRestaurantProviderListener) {
        listeners.removeAll(where: {listener in return restListener === listener})
    }
    
    
    public func get(lat: Double, lng: Double, rad: Double) {
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lng)&radius=\(rad)&type=restaurant&key=\(apiKey)")!
        restManager.dataTask(with: URLRequest(url: url), completionHandler: getRestClosure()).resume()
    }
    
    private func isResponseGood(data:Data?, response:URLResponse?, error:Error?) -> Bool {
        return data != nil && (response as! HTTPURLResponse).statusCode == 200 && error == nil
    }
    
    private func getRestClosure() -> RestClosure {
        return {[self] data, response, error in
            if(isResponseGood(data:data, response:response, error:error)){
                do{  try informListeners(restaurants: mapper.map(data: data!)) }
                catch { informListenersError(error: KotlinException(error: error)) }
            }
            else{
                informListenersError(error: KotlinException(message: "error:\(error.debugDescription), response: \(response.debugDescription)"))
            }
        }
    }
    
    private func informListeners(restaurants:[ModelRestaurant]){
        for listener in listeners {
            listener.onReceive(elements: restaurants)
        }
    }
    
    private func informListenersError(error:KotlinException){
        for listener in listeners{
            listener.onError(error: error)
        }
    }
    
    public func search(query: String) {
        
    }
    
    
}

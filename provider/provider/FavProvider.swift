//
//  FavProvider.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation
import presenter

public class FavProvider: IFavProvider {
    private var listeners = [IFavProviderListener]()
    private let userDefaults:IUserDefaults
    private let FAVS_KEY = "favs"
    
    public init(userDefaults:IUserDefaults){
        self.userDefaults = userDefaults
    }
    
    public func addListener(favListener: IFavProviderListener) {
        listeners.append(favListener)
    }
    
    public func removeListener(favListener: IFavProviderListener) {
        listeners.removeAll(where: {listener in return favListener === listener})
    }
    
    public func get() {
        let favs = userDefaults.object(forKey: FAVS_KEY)
        if favs != nil {
            informListeners(favs: favs as! [String])
        }
        else{
            informListenersError(error: KotlinException(message: "no favs"))
        }
    }
    
    private func informListenersError(error:KotlinException){
        for listener in listeners {
            listener.onError(error: error)
        }
    }
    
    private func informListeners(favs:[String]){
        for listener in listeners{
            listener.onReceive(names: favs)
        }
    }
    
    public func delete(name: String) {
        let favs = userDefaults.object(forKey: FAVS_KEY)
        if favs != nil {
            var favsList = favs as! [String]
            favsList.removeAll{favString in return favString == name}
            userDefaults.set(favsList, forKey: FAVS_KEY)
        } else {
            informListenersError(error: KotlinException(message: "nothing to delete! name: \(name)"))
        }
    }
    
    public func save(name: String) {
        let favs = userDefaults.object(forKey: FAVS_KEY)
        if favs == nil {
            var favsList = [String]()
            favsList.append(name)
            userDefaults.set(favsList, forKey: FAVS_KEY)
        } else{
            var favsList = favs as! [String]
            favsList.append(name)
            userDefaults.set(favsList, forKey: FAVS_KEY)
        }
    }
    
}

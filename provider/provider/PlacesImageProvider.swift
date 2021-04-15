//
//  ImageProvider.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation
import presenter

open class PlacesImageProvider: IImageProvider {
    private var listeners = [IImageProviderListener]()
    private let restManager:IRestManager
    private let apiKey:String
    
    public init(manager:IRestManager, apiKey:String){
        self.restManager = manager
        self.apiKey = apiKey
    }
    
    private func informListenersNon200(imgRef:String, response:HTTPURLResponse){
        for listener in listeners {
            listener.onError(imgRef: imgRef, error: KotlinException(message: "status code: \(response.statusCode), response: \(response)"))
        }
    }
    
    private func informListenersUnexpectedError(imgRef:String){
        for listener in listeners {
            listener.onError(imgRef: imgRef, error: KotlinException(message: "unexpected error"))
        }
    }
    
    private func informListeners(data:Data, imgRef:String){
        for listener in listeners {
            listener.onReceive(imgRef: imgRef, imgBase64: data.base64EncodedString())
        }
    }
    
    private func getRestClosure(imgRef:String) -> RestClosure {
        return {[self] data,response,error in
            if let uResponse = response as? HTTPURLResponse {
                if let uData = data {
                    if(uResponse.statusCode == 200) {
                        informListeners(data: uData, imgRef: imgRef)
                    }
                    else { informListenersNon200(imgRef: imgRef, response: uResponse)}
                }
                else{informListenersUnexpectedError(imgRef: imgRef)}
            }
            else{informListenersUnexpectedError(imgRef: imgRef)}
        }
    }
    
    public func get(imgRef: String) {
        let url = URL(string:"https://maps.googleapis.com/maps/api/place/photo?maxwidth=75&maxheight=75&photoreference=\(imgRef)&key=\(apiKey)")!
        restManager.dataTask(with: URLRequest(url: url), completionHandler: getRestClosure(imgRef:imgRef)).resume()
    }
    
    public func removeListener(imgListener: IImageProviderListener) {
        listeners.removeAll(where: {listener in return imgListener === listener})
    }
    
    public func addListener(imgListener: IImageProviderListener) {
        listeners.append(imgListener)
    }
}

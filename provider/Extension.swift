//
//  Extension.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation
import presenter


public protocol IRestTask {
  func resume()
  func cancel()
}

public protocol IRestManager {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession : IRestManager{}
extension URLSessionDataTask : IRestTask{}

extension KotlinException {
    convenience init(error:Error){
        self.init(message: error.localizedDescription)
    }
}

extension Double {
    func toKotlinDouble() -> KotlinDouble {
        return KotlinDouble(double: self)
    }
}

public protocol IUserDefaults {
    func set(_:Any?, forKey:String)
    func object(forKey:String) -> Any?
}

extension UserDefaults: IUserDefaults {}

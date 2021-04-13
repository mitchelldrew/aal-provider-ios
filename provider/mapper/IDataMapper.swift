//
//  IDataMapper.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation

open class IDataMapper<O>: IMapper {
    typealias I = Data
    
    public func map(data: Data) throws -> O { fatalError("Override me!") }
    
    public func map(data: O) throws -> Data { fatalError("Override me!") }
}

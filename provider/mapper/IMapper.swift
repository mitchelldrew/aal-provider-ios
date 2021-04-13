//
//  IMapper.swift
//  provider
//
//  Created by Mitchell Drew on 13/4/21.
//

import Foundation

protocol IMapper {
    associatedtype I
    associatedtype O
    func map(data:I) throws -> O
    func map(data:O) throws -> I
}

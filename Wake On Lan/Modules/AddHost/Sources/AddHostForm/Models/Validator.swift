//
//  Validator.swift
//  Wake on LAN
//
//  Created by Владислав Лисянский on 17.05.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

protocol Validator {
    associatedtype Value

    func validate(value: Value) -> Bool
}

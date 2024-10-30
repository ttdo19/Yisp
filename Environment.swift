//
//  Environment.swift
//  Yisp
//
//  Created by Trang Do on 10/29/24.
//

import Foundation

class Environment {
    
    var symbols = List(items: [])
    var values = List(items: [])
    
    func lookup(_ symbol: SExpr) throws -> SExpr {
        if let index = try symbols.items.firstIndex(where: { sym in mapToBool(try eq(symbol, sym))}) {
            return values.items[index]
        }
        // if we cannot find the symbol, return the symbol
        return symbol
    }
    
    func set(_ name: SExpr,_ value: SExpr) throws {
        // if symbol is in the environment, update the symbol to the new value
        if let index = try symbols.items.firstIndex(where: { sym in mapToBool(try eq(name, sym))}) {
            values.items[index] = value
        } else {
            // add the name to the symbols list and value to the values list
            symbols = try cons(name, symbols)
            values = try cons(value, values)
        }
    }
    
}

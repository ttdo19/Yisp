//
//  Token.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/26/24.
//

import Foundation

class Token {
    let type: TokenType
    let lexeme: String
    let literal: Any?
    let line: Int

    init(type: TokenType, lexeme: String = "", literal: Any? = nil, line: Int) {
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }

    func toString() -> String {
        return "\(type) \(lexeme) \(literal ?? "")"
    }
}

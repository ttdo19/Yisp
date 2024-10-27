//
//  TokenType.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/26/24.
//

import Foundation

enum TokenType {
    // special tokens.
    case leftParen, rightParen, singleQuote

    // atoms
    case symbol, string, number

    case eof
}

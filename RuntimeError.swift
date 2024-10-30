//
//  RunTimeError.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/26/24.
//

import Foundation

enum RuntimeError: Error {
    case mismatchedType(String)
    case unexpected(String)
    case undefinedVariable(String)
    case notCallable(Token, String)
    case incorrectNumberArguments(String)
    case cannotGetProperty(Token, String)
}

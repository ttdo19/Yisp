//
//  Parser.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/27/24.
//
enum ParseError: Error {
    case token
}

import Foundation
class Parser {
    private let tokens : [Token]
    private var current : Int = 0
    private let errorReporting: ErrorReporting
    
    init(tokens: [Token], errorReporting: ErrorReporting) {
        self.tokens = tokens
        self.errorReporting = errorReporting
    }
    
    func parse() -> [SExpr] {
        var sexprs : [SExpr] = []
        while (!isAtEnd()) {
            do {
                try sexprs.append(sexpression())
            } catch {
                synchronize()
            }
        }
        return sexprs
    }
    
    func sexpression() throws -> SExpr {
        if match([.leftParen]) {
            // if it starts with an open parenthesis, it is a list
            return try list()
        } else if match([.rightParen]) {
            // if we get an open parenthesis here, it must be unmatched
            throw error(token: peek(), message: "Mismatch ')'.")
        } else {
            // if not, it is atom
            return try atom()
        }
    }
    
    func list() throws -> SExpr {
        var element : [SExpr] = []
        while (!match([.rightParen])) {
            if (isAtEnd()) {
                throw error(token: previous(), message: "Mismatch ')'.")
            }
            // add the element of the list
            try element.append(sexpression())
        }
        return SExpr.List(items: element)
    }
    
    func atom() throws -> SExpr {
        if match([.number, .string]) {
            return SExpr.Atom(value: previous().literal)
        } else if match([.symbol]) {
            return SExpr.Atom(value: previous())
        } else if match([.singleQuote]) {
            // if it is a single quote, add it to the sexpr as a list where the first element is a quote, the second element is the quoted element
            var sexpr : [SExpr] = []
            sexpr.append(SExpr.Atom(value: Token(type: .singleQuote, line: previous().line)))
            let quotedElement = try sexpression()
            sexpr.append(quotedElement)
            return SExpr.List(items: sexpr)
        }
        throw error(token: peek(), message: "Expect atom")
    }
    
    func match(_ tokenTypes: [TokenType]) -> Bool {
        for tokenType in tokenTypes {
            if (check(tokenType)) {
                advance()
                return true
            }
        }
        return false
    }
    
    @discardableResult
    func consume(type: TokenType, message: String) throws -> Token {
        if (check(type)) {
            return advance()
        }
        throw error(token: peek(), message: message)
    }
    
    func check(_ tokenType: TokenType) -> Bool {
        if isAtEnd() {
            return false
        }
        return peek().type == tokenType
     }
    
    @discardableResult
    func advance() -> Token{
        if !isAtEnd() {
            current += 1
        }
        return previous()
    }
    
    func isAtEnd() -> Bool {
        return peek().type == .eof
    }

    func peek() -> Token {
        return tokens[current]
    }

    func previous() -> Token {
        return tokens[current-1]
    }
    
    func error(token: Token, message: String) -> ParseError {
        errorReporting.error(at: token, message: message)
        return ParseError.token
    }
    
    func synchronize() {
        advance()
        
        while !isAtEnd() {
            if previous().type == .rightParen {
                return
            }
            
            switch peek().type {
            case .leftParen:
                return
            default:
                break
            }
            
            advance()
        }
    }
}

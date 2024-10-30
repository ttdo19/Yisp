//
//  Scanner.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/26/24.
//

import Foundation

class Scanner {
    private let source: String
    private var tokens: [Token] = []
    
    private var start = 0
    private var current = 0
    private var line = 1
    
    private var isAtEnd: Bool {
        current >= source.count
    }
    private let errorReporting: ErrorReporting
    
    init(source: String, errorReporting: ErrorReporting) {
        self.source = source
        self.errorReporting = errorReporting
        
    }
    
    func scanTokens() -> [Token] {
        while (!isAtEnd) {
            // We are at the beginning of the next lexeme.
            start = current;
            scanToken()
        }
        let token = Token(type: .eof, line: line)
        tokens.append(token)
        return tokens
     }
    
    func scanToken() {
        let c = advance()
        switch c {
        case "(":
            addToken(.leftParen)
        case ")":
            addToken(.rightParen)
        case "-", "+", "*", "=", "/":
            addToken(.symbol)
        case "<", ">":
            let _ = match("=")
            addToken(.symbol)
        case "\'":
            addToken(.singleQuote)
        case " ", "\r", "\t":
            // Ignore whitespace.
            break
        case "\n":
            line += 1
        case "\"":
            string()
        default:
            if (isDigit(c)) {
                number()
            } else if (isAlpha(c)) {
                symbol()
            } else {
                errorReporting.error(line, "Unexpected character.")
            }
        }
    }
    
    @discardableResult
    func advance() -> Character {
        let char = source[current]
        current += 1
        return char
    }
                    
    func addToken(_ type: TokenType, _ literal: Any? = nil) {
        let text = String(source[start..<current])
        let token = Token(type: type, lexeme: text, literal: literal, line: line)
        tokens.append(token)
    }
    
    func match(_ expected: Character) -> Bool {
        if (isAtEnd || source[current] != expected) {
            return false
        }
        current += 1
        return true
    }
    
    func peek() -> Character{
        if (isAtEnd) {
            return "\0"
        }
        return source[current]
    }
    
    func string() {
        while (peek() != "\"" && !isAtEnd) {
            if (peek() == "\n") {
                line += 1
            }
            advance()
        }
        if isAtEnd {
            errorReporting.error(line, "Unterminated string.")
            return
        }
        
        // The closing ".
        advance()
        
        // Trim the surrounding quotes.
        let value = String(source[start+1..<current-1])
        addToken(.string, value)
    }
    
    func isDigit(_ c: Character) -> Bool {
        return c >= "0" && c <= "9"
    }
    
    func number() {
        while (isDigit(peek())) {
            advance()
        }
        // Look for a fractional part.
        if (peek() == "." && isDigit(peekNext())) {
            // Consume the "."
            advance()
            while (isDigit(peek())) {
                advance()
            }
        }
        addToken(.number,Double(source[start..<current]));
    }
    
    func peekNext() -> Character {
        guard (current + 1 < source.count) else {
            return "\0"
        }
        return source[current+1]
    }
    
    func symbol() {
        while (isAlphaNumeric(peek())) {
            advance()
        }
        let text = String(source[start..<current])
        addToken(.symbol, text)
    }
    
    func isAlpha(_ c: Character) -> Bool {
        return (c >= "a" && c <= "z") || (c >= "A" && c <= "Z" || c == "_" || c == "?" || c == "-")
    }
    
    func isAlphaNumeric(_ c: Character) -> Bool {
        return isAlpha(c) || isDigit(c)
    }
}

//https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift/38215613#38215613
extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
}

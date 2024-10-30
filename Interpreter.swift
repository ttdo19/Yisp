//
//  Interpreter.swift
//  Yisp
//
//  Created by Trang Do on 10/29/24.
//

import Foundation

class Interpreter {
    var errorReporting: ErrorReporting!
    var global = Environment()
    
//    init(errorReporting: ErrorReporting) {
//        self.errorReporting = errorReporting
//    }
    
    func interpret(_ sexpr: [SExpr]) {
        do {
            for s in sexpr {
                print(try eval(s).toString())
            }
        } catch let error as RuntimeError {
            errorReporting.runtimeError(error)
        } catch {
            let unexpectedError = RuntimeError.unexpected("Unexpected runtime error: \(error.localizedDescription)")
            errorReporting.runtimeError(unexpectedError)
        }
    }
    
    func eval(_ arg: SExpr) throws -> SExpr {
        if (mapToBool(isNil(arg)) || mapToBool(isNumber(arg))) {
            // if arg is nil or a number, return arg
            return arg
        } else if (mapToBool(isSymbol(arg))) {
            // if arg is a symbol, check if symbol has a value and return the value
            return try global.lookup(arg)
        } else {
            // if it is not nil, a number or symbol, then it must be a list
            if let symbol = try car(arg) as? Atom, let symVal = symbol.value as? Token {
                if (symVal.lexeme == "\'" ||  symVal.lexeme == "quote") {
                    return try cadr(arg)
                } else if symVal.lexeme.lowercased() == "set" {
                    try global.set(try eval(cadr(arg)), try eval(caddr(arg)))
                    return try eval(caddr(arg))
                } else if symVal.lexeme.lowercased() == "+"{
                    return try atom(String(describing: add(try eval(cadr(arg)), try eval(caddr(arg)))))
                } else if symVal.lexeme.lowercased() == "-" {
                    return try atom(String(describing: sub(try eval(cadr(arg)), try eval(caddr(arg)))))
                } else if symVal.lexeme.lowercased() == "*" {
                    return try atom(String(describing: mul(try eval(cadr(arg)), try eval(caddr(arg)))))
                } else if symVal.lexeme.lowercased() == "/" {
                    return try atom(String(describing: div(try eval(cadr(arg)), try eval(caddr(arg)))))
                } else if symVal.lexeme.lowercased() == "mod" {
                    return try atom(String(describing: mod(try eval(cadr(arg)), try eval(caddr(arg)))))
                } else if symVal.lexeme.lowercased() == "<" {
                    return try lt(try eval(cadr(arg)), try eval(caddr(arg)))
                } else if symVal.lexeme.lowercased() == ">" {
                    return try gt(try eval(cadr(arg)), try eval(caddr(arg)))
                } else if symVal.lexeme.lowercased() == "<=" {
                    return try lte(try eval(cadr(arg)), try eval(caddr(arg)))
                } else if symVal.lexeme.lowercased() == ">=" {
                    return try gte(try eval(cadr(arg)), try eval(caddr(arg)))
                } else if symVal.lexeme.lowercased() == "not" {
                    return not(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "nil?" {
                    return isNil(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "symbol?" {
                    return isSymbol(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "number?" {
                    return isNumber(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "list?" {
                    return isList(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "car" {
                    return try car(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "cdr" {
                    return try cdr(try eval(cadr(arg)))
                } else if symVal.lexeme.lowercased() == "cons" {
                    return try cons(try eval(cadr(arg)), try eval(caddr(arg)))
                } else if symVal.lexeme.lowercased() == "eval" {
                    return try eval(try eval(cadr(arg)))
                }  else if (symVal.lexeme.lowercased() == "eq?" || symVal.lexeme.lowercased() == "=") {
                    return try eq(try eval(cadr(arg)), try eval(caddr(arg)) )
                }

            }
        }
        return Nil
    }
    
}

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
                if let sexprs = try cdr(arg) as? List {
                    if (symVal.lexeme == "\'" ||  symVal.lexeme == "quote") {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "quote")
                        // if quote, return cadr(arg)
                        return try cadr(arg)
                    } else if symVal.lexeme.lowercased() == "set" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "set")
                        // if set, return the value that a symbol is set to
                        try global.set(try eval(cadr(arg)), try eval(caddr(arg)))
                        return try eval(caddr(arg))
                    } else if symVal.lexeme.lowercased() == "+"{
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "addition")
                        // if addition, return the result of addidtion as an atom
                        return try atom(String(describing: add(try eval(cadr(arg)), try eval(caddr(arg)))))
                    } else if symVal.lexeme.lowercased() == "-" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "subtraction")
                        // if subtraction, return the result of substraction as an atom
                        return try atom(String(describing: sub(try eval(cadr(arg)), try eval(caddr(arg)))))
                    } else if symVal.lexeme.lowercased() == "*" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "multiplication")
                        // if multiplication, return the result of multiplication as an atom
                        return try atom(String(describing: mul(try eval(cadr(arg)), try eval(caddr(arg)))))
                    } else if symVal.lexeme.lowercased() == "/" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "division")
                        // if division, return the result of division as an atom
                        return try atom(String(describing: div(try eval(cadr(arg)), try eval(caddr(arg)))))
                    } else if symVal.lexeme.lowercased() == "mod" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "modular")
                        // if modular, return the result of modular as an atom
                        return try atom(String(describing: mod(try eval(cadr(arg)), try eval(caddr(arg)))))
                    } else if symVal.lexeme.lowercased() == "<" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "less than")
                        // if < is true, return T, else return Nil
                        return try lt(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if symVal.lexeme.lowercased() == ">" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "greater than")
                        // if > is true, return T, else return Nil
                        return try gt(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if symVal.lexeme.lowercased() == "<=" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "less than or equal")
                        // if <= is true, return T, else return Nil
                        return try lte(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if symVal.lexeme.lowercased() == ">=" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "greater than or equal")
                        // if >= is true, return T, else return Nil
                        return try gte(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if symVal.lexeme.lowercased() == "not" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "not")
                        // if not (), return T, else return ()
                        return not(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "nil?" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "nil?")
                        // if nil? (), return T, else return ()
                        return isNil(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "symbol?" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "symbol?")
                        // if symbol? symbol, return T, else return ()
                        return isSymbol(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "number?" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "number?")
                        // if number? number, return T, else return ()
                        return isNumber(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "list?" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "list?")
                        // if list? list, return T, else return ()
                        return isList(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "car" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "car")
                        // car return the first item of a list
                        return try car(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "cdr" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "cdr")
                        // cdr return the rest of the list except the first item
                        return try cdr(try eval(cadr(arg)))
                    } else if symVal.lexeme.lowercased() == "cons" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "cons")
                        // cons makes a list from 2 SExprs
                        return try cons(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if symVal.lexeme.lowercased() == "eval" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "eval")
                        // eval evaluates the value of SExpr
                        return try eval(try eval(cadr(arg)))
                    }  else if (symVal.lexeme.lowercased() == "eq?" || symVal.lexeme.lowercased() == "=") {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "eq?")
                        // eq? check if 2 atoms are equal, return T if true, Nil otherwise
                        return try eq(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if (symVal.lexeme.lowercased() == "and?") {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "and?")
                        // if the first SExpr is not (), evaluate the next one
                        if mapToBool(try eval(cadr(arg))) {
                            if mapToBool(try eval(caddr(arg))) {
                                // if both are not (), return T
                                return T
                            }
                        }
                        return Nil
                    } else if (symVal.lexeme.lowercased() == "or?"){
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "or?")
                        // if the first SExpr is (), evaluate the next one
                        if !mapToBool(try eval(cadr(arg))) {
                            if !mapToBool(try eval(caddr(arg))) {
                                // if both are ()), return Nil
                                return Nil
                            }
                        }
                        return T
                    } else if (symVal.lexeme.lowercased() == "if"){
                        try checkNumberArgument(expected: 3, actual: sexprs.items.count, functionName: "if")
                        if mapToBool(try eval(cadr(arg))) {
                            return try eval(caddr(arg))
                        }
                        return try eval(cadddr(arg))
                    } else if (symVal.lexeme.lowercased() == "cond") {
                        if (sexprs.items.count % 2 != 0) {
                            throw RuntimeError.incorrectNumberArguments("Expect an even number of arguments for cond function.")
                        }
                        for index in stride(from: 0, to: sexprs.items.count, by: 2) {
                            if (mapToBool(try eval(sexprs.items[index]))) {
                                return try eval(sexprs.items[index + 1])
                            }
                        }
                        throw RuntimeError.unexpected("No condition evaluates to true in the cond function.")
                    }
                }
            }
        }
        return Nil
    }
    
    func checkNumberArgument(expected: Int, actual: Int, functionName: String) throws {
        if (expected != actual) {
            throw RuntimeError.incorrectNumberArguments("Expect \(expected) number of arguments for \(functionName) function, but got \(actual).")
        }
    }
    
}

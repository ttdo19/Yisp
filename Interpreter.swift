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
    var environment: [Environment]
    var userFunc: [String] = []

    init () {
        environment = [global]
    }
    
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
            let currentEnvironment = environment.last!
            if (mapToBool(try eq(currentEnvironment.lookup(arg), arg))) {
                // if cannot find the symbol in the current environment, check the global environment
                return try global.lookup(arg)
            } else {
                return try currentEnvironment.lookup(arg)
            }
        } else {
            // if it is not nil, a number or symbol, then it must be a list
            if let symbol = try car(arg) as? Atom, let symVal = symbol.value as? Token {
                // if the car(arg) is an atom, find keyword matches the symbol
                if let sexprs = try cdr(arg) as? List {
                    if (symVal.lexeme == "\'" ||  symVal.lexeme.lowercased() == "quote") {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "quote")
                        // if quote, return cadr(arg)
                        return try cadr(arg)
                    } else if symVal.lexeme.lowercased() == "set" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "set")
                        // if set, return the value that a symbol is set to
                        try global.set(try eval(cadr(arg)), try eval(caddr(arg)))
                        return try eval(caddr(arg))
                    } else if (symVal.lexeme.lowercased() == "+" || symVal.lexeme.lowercased() == "add" || symVal.lexeme.lowercased() == "plus") {
                        let list = List(items: [])
                        for index in stride(from: 0, to: sexprs.items.count, by: 1) {
                            list.items.append(try eval(sexprs.items[index]))
                        }
                        // if addition, return the result of addidtion as an atom
                        return try atom(String(describing: add(list)))
                    } else if (symVal.lexeme.lowercased() == "-" ||  symVal.lexeme.lowercased() == "sub"){
                        let list = List(items: [])
                        for index in stride(from: 0, to: sexprs.items.count, by: 1) {
                            list.items.append(try eval(sexprs.items[index]))
                        }
                        // if addition, return the result of addidtion as an atom
                        return try atom(String(describing: sub(list)))
                    } else if (symVal.lexeme.lowercased() == "*" || symVal.lexeme.lowercased() == "mul"){
                        let list = List(items: [])
                        for index in stride(from: 0, to: sexprs.items.count, by: 1) {
                            list.items.append(try eval(sexprs.items[index]))
                        }
                        // if addition, return the result of addidtion as an atom
                        return try atom(String(describing: mul(list)))
                    } else if (symVal.lexeme.lowercased() == "/" || symVal.lexeme.lowercased() == "div") {
                        let list = List(items: [])
                        for index in stride(from: 0, to: sexprs.items.count, by: 1) {
                            list.items.append(try eval(sexprs.items[index]))
                        }
                        // if addition, return the result of addidtion as an atom
                        return try atom(String(describing: div(list)))
                    } else if symVal.lexeme.lowercased() == "mod" {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "modular")
                        // if modular, return the result of modular as an atom
                        return try atom(String(describing: mod(try eval(cadr(arg)), try eval(caddr(arg)))))
                    } else if (symVal.lexeme.lowercased() == "<" || symVal.lexeme.lowercased() == "lt"){
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "less than")
                        // if < is true, return T, else return Nil
                        return try lt(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if (symVal.lexeme.lowercased() == ">" || symVal.lexeme.lowercased() == "gt") {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "greater than")
                        // if > is true, return T, else return Nil
                        return try gt(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if (symVal.lexeme.lowercased() == "<=" || symVal.lexeme.lowercased() == "lte") {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "less than or equal")
                        // if <= is true, return T, else return Nil
                        return try lte(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if (symVal.lexeme.lowercased() == ">=" || symVal.lexeme.lowercased() == "gte") {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "greater than or equal")
                        // if >= is true, return T, else return Nil
                        return try gte(try eval(cadr(arg)), try eval(caddr(arg)))
                    } else if symVal.lexeme.lowercased() == "not" {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "not")
                        // if not (), return T, else return ()
                        return not(try eval(cadr(arg)))
                    } else if (symVal.lexeme.lowercased() == "nil?" || symVal.lexeme.lowercased() == "null?") {
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
                        return try eval(cadr(arg))
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
                    } else if (FUNC_DEFINE_KEYWORDS.contains(symVal.lexeme.lowercased())) {
                        try checkNumberArgument(expected: 3, actual: sexprs.items.count, functionName: "define")
                        // user defines a new function
                        let funcName = try cadr(arg)
                        let argList = try caddr(arg)
                        let funcBody = try cadddr(arg)
                        let funcDef = try cons(argList, funcBody)
                        try global.set(funcName, funcDef)
                        if let name = funcName as? Atom, let val = name.value as? Token {
                            // add the user define function name to the userFunc list
                            userFunc.append(val.lexeme)
                        }
                        return funcName
                    } else if (userFunc.contains(symVal.lexeme)) {
                        // user calls a user defined function
                        if let funcDef = try global.lookup(symbol) as? List {
                            // retrieve the argList and the body of funcDef
                            if let argList = try car(funcDef) as? List {
                                try checkNumberArgument(expected: argList.items.count, actual: sexprs.items.count, functionName: symVal.lexeme)
                                // create a new environment and eval the arg list and add them to the environment
                                let newEnvironment = Environment()
                                for index in stride(from: 0, to: sexprs.items.count, by: 1) {
                                    try newEnvironment.set(argList.items[index], try eval(sexprs.items[index]))
                                }
                                environment.append(newEnvironment)
                            }
                            let body = try cdr(funcDef)
                            let result = try eval(body)
                            environment.removeLast()
                            return result
                        }
                    } else if (symVal.lexeme.lowercased() == "eqlist?") {
                        try checkNumberArgument(expected: 2, actual: sexprs.items.count, functionName: "eqlist?")
                        if let list1 = try eval(try car(sexprs)) as? List, let list2 = try eval(try car(try cdr(sexprs))) as? List {
                            if (list1.items.count != list2.items.count) {
                                return Nil
                            }
                            for index in stride(from: 0, to: list1.items.count, by: 1) {
                                if (!mapToBool(try eq(try eval(list1.items[index]), try eval(list2.items[index])))) {
                                    return Nil
                                }
                            }
                            return T
                        }
                        throw RuntimeError.mismatchedType("Can only use eqlist? to compare between a list and a list.")
                    } else if (symVal.lexeme.lowercased() == "cadr") {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "cadr")
                        // cadr return the second item of the list
                        return try cadr(try eval(cadr(arg)))
                    } else if (symVal.lexeme.lowercased() == "caddr") {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "caddr")
                        // cadr return the third item of the list
                        return try caddr(try eval(cadr(arg)))
                    } else if (symVal.lexeme.lowercased() == "cadddr") {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "cadddr")
                        // cadr return the fourth item of the list
                        return try cadddr(try eval(cadr(arg)))
                    } else if (symVal.lexeme.lowercased() == "atom?") {
                        try checkNumberArgument(expected: 1, actual: sexprs.items.count, functionName: "atom?")
                        // cadr return the fourth item of the list
                        return isAtom(try eval(cadr(arg)))
                    }
                }
            } else if let list = try car(arg) as? List{
                // if the car(arg) is an list check if car(car(arg)) is lambda
                if let symbol = try car(car(arg)) as? Atom, let symVal = symbol.value as? Token  {
                    if (symVal.lexeme.lowercased() == "lambda") {
                        if let argActualVal = try cdr(arg) as? List {
                            let newEnvironment = Environment()
                            if let argList = try cadr(list) as? List {
                                for index in stride(from: 0, to: argList.items.count, by: 1) {
                                    try newEnvironment.set(argList.items[index], try eval(argActualVal.items[index]))
                                }
                            }
                            environment.append(newEnvironment)
                        }
                        let lambdaBody = try caddr(list)
                        let result = try eval(lambdaBody)
                        environment.removeLast()
                        return result
                    }
                }
            }
        }
        throw RuntimeError.unexpected("Cannot successfully evaluate the given sexpressions.")
    }
    
    func checkNumberArgument(expected: Int, actual: Int, functionName: String) throws {
        if (expected != actual) {
            throw RuntimeError.incorrectNumberArguments("Expect \(expected) number of arguments for \(functionName) function, but got \(actual).")
        }
    }
    
}

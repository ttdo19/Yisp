//
//  NativeFunc.swift
//  Yisp
//
//  Created by Trang Do on 10/28/24.
//
import Foundation

typealias List = SExpr.List
typealias Atom = SExpr.Atom

func mapToBool(_ sexpr: SExpr) -> Bool {
    if let sexpr = sexpr as? List {
        if (sexpr.items.count == 0) {
            return false
        }
    }
    return true
}

func isNil(_ sexpr: SExpr) -> SExpr {
    if (!mapToBool(sexpr)) {
        return T
    }
    return Nil
}

func isAtom(_ sexpr: SExpr) -> SExpr {
    if let _ = sexpr as? Atom {
        return T
    }
    return Nil
}

func isSymbol(_ sexpr: SExpr) -> SExpr {
    if let sexpr = sexpr as? Atom {
        if let val = sexpr.value as? Token {
            if (val.type == .symbol) {
                return T
            }
        }
    }
    return Nil
}

func isNumber(_ sexpr: SExpr) -> SExpr {
    if let sexpr = sexpr as? Atom {
        if let val = sexpr.value as? Token {
            if (val.type == .number) {
                return T
            }
        }
    }
    return Nil
}

func isList(_ sexpr: SExpr) -> SExpr {
    if let _ = sexpr as? List {
        return T
    }
    return Nil
}

func atom(_ val: String) -> SExpr {
    if (Double(val) != nil) {
        return Atom(value: Token(type: .number, lexeme: val, literal: Double(val), line: 1))
    } else {
        return Atom(value: Token(type: .symbol, lexeme: val, literal: val, line: 1))
    }
}

func cons(_ val: SExpr, _ list: SExpr) throws -> List {
    if let list = list as? List {
        let newList = List(items: [val] + list.items)
        return newList
    }
    throw RuntimeError.unexpected("Can only perform cons between an atom and a list.")
}

func car(_ sexpr: SExpr) throws -> SExpr {
    if let sexpr = sexpr as? List {
        if sexpr.items.count > 0 {
            return sexpr.items[0]
        }
        throw RuntimeError.unexpected("Can only perform car on an non-empty list.")
    } else {
        throw RuntimeError.unexpected("Can only perform car on a list.")
    }
}

func cdr(_ sexpr: SExpr) throws -> SExpr {
    if let sexpr = sexpr as? List {
        if sexpr.items.count > 0 {
            return List(items: Array(sexpr.items.dropFirst()))
        } else {
            throw RuntimeError.unexpected("Can only perform car on an non-empty list.")
        }
    } else {
        throw RuntimeError.unexpected("Can only perform cdr on a list.")
    }
}

func getValueFromNumber(_ sexpr: Atom) throws -> Double? {
    if let val = sexpr.value as? Token {
        if (val.type == .number) {
            if let v = val.literal as? Double {
                return v
            }
        }
    }
    throw RuntimeError.unexpected("Cannot get value from non-number.")
}

func getValueFromString(_ sexpr: Atom) throws -> String? {
    if let val = sexpr.value as? Token {
        if (val.type == .string) {
            return sexpr.toString()
        }
    }
    throw RuntimeError.unexpected("Cannot get value from non-number.")
}

func isInt(_ num: Double) -> Bool {
    if (floor(num) == num) {
        return true
    }
    return false
}

func add(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> Any {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            let result = val1 + val2
            return isInt(result) ? Int(result) : result
        }
    }
    throw RuntimeError.unexpected("Can only perform addition operation between numbers.")
}

func sub(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> Any {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            let result = val1 - val2
            return isInt(result) ? Int(result) : result
        }
    }
    throw RuntimeError.unexpected("Can only perform subtraction operation between numbers.")
}

func mul(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> Any {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            let result = val1 * val2
            return isInt(result) ? Int(result) : result
        }
    }
    throw RuntimeError.unexpected("Can only perform multiplication operation between numbers.")
}

func div(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> Any {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            if val2 != 0 {
                let result = val1 / val2
                return isInt(result) ? Int(result) : result
            } else {
                throw RuntimeError.unexpected("Division by zero is not allowed.")
            }
        }
    }
    throw RuntimeError.unexpected("Can only perform division operation between numbers.")
}

func mod(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> Int {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            if floor(val1) == val1 && floor(val2) == val2 {
                return Int(val1) % Int(val2)
            } else {
                throw RuntimeError.unexpected("Modular operation only works on integers.")
            }
        }
    }
    throw RuntimeError.unexpected("Can only perform modular operation between numbers.")
}

func lt(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> SExpr {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            return (val1 < val2) ? T : Nil
        }
    }
    throw RuntimeError.unexpected("Can only perform comparison operation between numbers.")
}

func gt(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> SExpr {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            return (val1 > val2) ? T : Nil
        }
    }
    throw RuntimeError.unexpected("Can only perform comparison operation between numbers.")
}

func lte(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> SExpr {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            return (val1 <= val2) ? T : Nil
        }
    }
    throw RuntimeError.unexpected("Can only perform comparison operation between numbers.")
}

func gte(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> SExpr {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        let val1 = try getValueFromNumber(sexpr1)
        let val2 = try getValueFromNumber(sexpr2)
        if let val1 = val1, let val2 = val2{
            return (val1 >= val2) ? T : Nil
        }
    }
    throw RuntimeError.unexpected("Can only perform comparison operation between numbers.")
}

func eq(_ sexpr1: SExpr, _ sexpr2: SExpr) throws -> SExpr {
    if let sexpr1 = sexpr1 as? Atom, let sexpr2 = sexpr2 as? Atom {
        if let val1 = sexpr1.value as? Token, let val2 = sexpr2.value as? Token {
            //case 1: if both sexprs are symbols
            if (val1.type == val2.type && val1.type == .symbol){
                return val1.lexeme == val2.lexeme ? T : Nil
            }
            //case 2: if both sexprs are numbers
            else if (val1.type == val2.type && val1.type == .number){
                let v1 = try getValueFromNumber(sexpr1)
                let v2 = try getValueFromNumber(sexpr2)
                if let v1 = v1, let v2 = v2 {
                    return v1 == v2 ? T : Nil
                }
            }
            //case 3: if both sexprs are strings
            else if (val1.type == val2.type && val1.type == .string){
                let v1 = try getValueFromString(sexpr1)
                let v2 = try getValueFromString(sexpr2)
                if let v1 = v1, let v2 = v2 {
                    return v1 == v2 ? T : Nil
                }
            }
        } else if let val1 = sexpr1.value as? Bool, let val2 = sexpr2.value as? Bool  { // compare the constant truth
            return val1 == val2 ? T : Nil
        }
    }
    return Nil
}

func not (_ sexpr: SExpr) -> SExpr {
    if mapToBool(sexpr) {
        return Nil
    }
    return T
}

func cadr (_ sexpr: SExpr) throws -> SExpr {
    return try car(cdr(sexpr))
}

func caddr (_ sexpr: SExpr) throws -> SExpr {
    return try car(cdr(cdr(sexpr)))
}


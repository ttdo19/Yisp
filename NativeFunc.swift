//
//  NativeFunc.swift
//  Yisp
//
//  Created by Trang Do on 10/28/24.
//

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
        return Atom(value: Token(type: .number, lexeme: val, literal: val, line: 1))
    } else {
        return Atom(value: Token(type: .symbol, lexeme: val, literal: val, line: 1))
    }
}

func cons(_ val: SExpr, _ list: SExpr) -> SExpr {
    if let list = list as? List {
        let newList = List(items: [val] + list.items)
        return newList
    }
    return Nil
}

func car(_ sexpr: SExpr) -> SExpr {
    if let sexpr = sexpr as? List {
        if sexpr.items.count > 0 {
            return sexpr.items[0]
        }
    }
    return Nil
}

func cdr(_ sexpr: SExpr) -> SExpr {
    if let sexpr = sexpr as? List {
        if sexpr.items.count > 1 {
            return List(items: Array(sexpr.items.dropFirst()))
        }
    }
    return Nil
}


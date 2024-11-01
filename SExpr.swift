//
//  SExpr.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/27/24.
//

let Nil: SExpr = SExpr.List(items: [])
let T: SExpr = SExpr.Atom(value: true)

class SExpr: @unchecked Sendable {
    func toString() -> String {
        ""
    }
    
    class Atom: SExpr, @unchecked Sendable {
        let value: Any?
        
        init(value: Any?) {
            self.value = value
        }
        
        override func toString() -> String {
            if let val = value as? Double {
                var text = String(val)
                text = text.hasSuffix(".0") ? String(text.dropLast(2)): text
                return text
            } else if let val = value as? Int {
                return String(val)
            } else if let val = value as? String {
                return "\"" + val + "\""
            } else if let val = value as? Token {
                return val.lexeme
            } else if let val = value as? Bool, val == true {
                return "T"
            }
            return String(describing: value)
        }
        
    }
    class List: SExpr, @unchecked Sendable {
        var items: [SExpr]
        
        init(items: [SExpr]) {
            self.items = items
        }
        
        override func toString() -> String {
            var str = "("
            for item in items {
                if let item = item as? Atom {
                    str += item.toString() + " "
                } else if let list = item as? List {
                    str += list.toString() + " "
                }
            }
            if (items.count > 0) {
                str = str.dropLast(1) + ")" // Remove the extra space before adding the closing parenthesis
            } else {
                str += ")" // this list is just nil
            }
            return str
        }
    }
}


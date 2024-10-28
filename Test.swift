//
//  Test.swift
//  Yisp
//
//  Created by Trang Do on 10/27/24.
//
import Foundation

let inputSprint1 : [String] = [
    "(+ 2 3)",
    "(/ 6 (+ 2 1))",
    "(* 9 (/ 6 (+ 2 1)))",
    "(- 8 (* 9 (/ 6 (+ 2 1))))",
    "(+ 1 (- 8 (* 9 (/ 6 (+ 2 1)))))",
    "(set a 1)",
    "(+ a (- 8 (* 9 (/ 6 (+ 2 1)))))",
    "(set pi 3.14)",
    "(* pi 3)"
]

extension Yisp {
    func testSprint1() {
        for line in inputSprint1 {
            let scanner = Scanner(source: line , errorReporting: self)
            let tokens = scanner.scanTokens()
            
            let parser = Parser(tokens: tokens, errorReporting: self)
            let sexpressions = parser.parse()
            guard(!hadError) else {return}
            
            for sexpr in sexpressions {
                print(sexpr.toString())
            }
        }
    }
    
    func testSprint2() {
        print("Test 1: Nil is")
        print(Nil.toString())
        
        print("Test 2: Truth is")
        print(T.toString())
        
        print ("Test 3: make atom(\"symbol\")")
        print(atom("symbol").toString())
        
        print ("Test 4: make atom(\"411\")")
        print(atom("411").toString())
        
        print("Test 5: make a list cons(atom(\"one\"), cons(atom(\"two\"), cons(atom(\"three\"), Nil)))")
        print(cons(atom("one"), cons(atom("two"), cons(atom("three"), Nil))).toString())
        
        print("Test 6: car (first, second, third)")
        print(car(cons(atom("first"), cons(atom("second"), cons(atom("third"), Nil)))).toString())
        
        print("Test 7: cdr (first, second, third)")
        print(cdr(cons(atom("first"), cons(atom("second"), cons(atom("third"), Nil)))).toString())
        
        print("Test 8: isList(one, two, three)")
        print(isList(cons(atom("one"), cons(atom("two"), cons(atom("three"), Nil)))).toString())
        
        print("Test 9: atom? a")
        print(isAtom(atom("a")).toString())
        
        print("Test 10: nil? ()")
        print(isNil(Nil).toString())
        
        print("Test 11: symbol? 1289")
        print(isSymbol(atom("1289")).toString())
        
        print("Test 12: number? 2197")
        print(isNumber(atom("2187")).toString())
        
        print("Test 12: symbol? abc")
        print(isSymbol(atom("abc")).toString())
        
        print("Test 13: nil? hello")
        print(isNil(atom("hello")).toString())
    }
}

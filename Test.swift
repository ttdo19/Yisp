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
        do {
            print("Test 1: Nil is")
            print(Nil.toString())
            
            print("Test 2: Truth is")
            print(T.toString())
            
            print ("Test 3: make atom(\"symbol\")")
            print(atom("symbol").toString())
            
            print ("Test 4: make atom(\"411\")")
            print(atom("411").toString())
            
            print("Test 5: make a list cons(atom(\"one\"), cons(atom(\"two\"), cons(atom(\"three\"), Nil)))")
            try print(cons(atom("one"), cons(atom("two"), cons(atom("three"), Nil))).toString())
            
            print("Test 6: car (first, second, third)")
            try print(car(cons(atom("first"), cons(atom("second"), cons(atom("third"), Nil)))).toString())
            
            print("Test 7: cdr (first, second, third)")
            try print(cdr(cons(atom("first"), cons(atom("second"), cons(atom("third"), Nil)))).toString())
            
            print("Test 8: isList(one, two, three)")
            try print(isList(cons(atom("one"), cons(atom("two"), cons(atom("three"), Nil)))).toString())
            
            print("Test 9: atom? a")
            print(isAtom(atom("a")).toString())
            
            print("Test 10: nil? ()")
            print(isNil(Nil).toString())
            
            print("Test 11: symbol? 1289")
            print(isSymbol(atom("1289")).toString())
            
            print("Test 12: number? 2197")
            print(isNumber(atom("2187")).toString())
            
            print("Test 13: symbol? abc")
            print(isSymbol(atom("abc")).toString())
            
            print("Test 14: nil? hello")
            print(isNil(atom("hello")).toString())
             
        } catch let error as RuntimeError {
            self.runtimeError(error)
        } catch {
            let unexpectedError = RuntimeError.unexpected("Unexpected runtime error: \(error.localizedDescription)")
            self.runtimeError(unexpectedError)
        }
    }
    
    func testSprint3() {
        do {
            print("Test 1: add 2 3")
            try print(add(atom("2"), atom("3")))
            
            print("Test 2: sub 3 2")
            try print(sub(atom("3"), atom("2")))
            
            print ("Test 3: eq 2 2")
            try print(eq(atom("2"), atom("2")).toString())
            
            print ("Test 4: lt 2 3")
            try print(lt(atom("2"), atom("3")).toString())
            
            print("Test 5: gte 3 2")
            try print(gte(atom("3"), atom("2")).toString())
            
            print("Test 6: mul 2 3")
            try print(mul(atom("2"), atom("3")))
            
            print("Test 7: mul 15 3")
            try print(div(atom("15"), atom("3")))
            
            print("Test 8: mod 25 3")
            try print(mod(atom("25"), atom("3")))

            print("Test 9: lte 6 9")
            try print(lte(atom("6"), atom("9")).toString())

            print("Test 10: gt 28 2")
            try print(gt(atom("28"), atom("2")).toString())

            print("Test 11: not? ()")
            print(not(Nil).toString())

            print("Test 12: not? 2187")
            print(not(atom("2187")).toString())
            
            print("Test 13: not? (1 2 3)")
            try print(not(cons(atom("one"), cons(atom("two"), cons(atom("three"), Nil)))).toString())
            
        } catch let error as RuntimeError {
            self.runtimeError(error)
 
        } catch {
            let unexpectedError = RuntimeError.unexpected("Unexpected runtime error: \(error.localizedDescription)")
            self.runtimeError(unexpectedError)

        }
    }
}

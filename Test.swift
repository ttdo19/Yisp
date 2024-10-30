//
//  Test.swift
//  Yisp
//
//  Created by Trang Do on 10/27/24.
//
import Foundation

let inputSprint4 : [String] = [
    "(+ 2 3)",
    "(/ 6 (+ 2 1))",
    "(* 9 (/ 6 (+ 2 1)))",
    "(- 8 (* 9 (/ 6 (+ 2 1))))",
    "(+ 1 (- 8 (* 9 (/ 6 (+ 2 1)))))",
    "(set a 1)",
    "(+ a (- 8 (* 9 (/ 6 (+ 2 1)))))",
    "(set pi 3.14)",
    "(* pi 3)",
    "(/ (/ 510 3) 10)",
    "(eq? 1 1)",
    "(set c (cons 1 (cons 2 (cons 3 ()))))",
    "(eq? (car c) (quote 1))",
    "(= (+ 20 30) 50)",
    "(= () 1)",
    "(= () ())",
    "(= ('a) ('a))",
    "(set b 10)",
    "(= b 10)",
    "(< 10 (+ 7 5))",
    "(>= 2.89 1.29)",
    "(<= b 20)",
    "(> b a)",
    "(cons 1 (cons 2 (cons 3 ())))",
    "(car(cons 29 (cons 30 ())))",
    "(cons (cons 1 (cons 2 (cons 3 ()))) (cons 29 (cons 30 ())))",
    "(cons () ())",
    "(cons () (cons () ()))",
    "(car (cdr (cdr (cdr (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ())))))))))",
    "(cdr (cdr (cdr (cdr (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ())))))))))",
    "(number? (+ 1 2))",
    "(number? ())",
    "(number? (cons 1 (cons 2 (cons 3 ()))))",
    "(symbol? 289)",
    "(symbol? abc)",
    "(symbol? ('abc))",
    "(list? (cons 1 (cons 2 (cons 3 ()))))",
    "(list? 123)",
    "(list? ())",
    "(nil? ())",
    "(nil? 123)",
    "(nil? (cons 1 (cons 2 (cons 3 ()))))",
    "(not ())",
    "(not (cons 1 (cons 2 (cons 3 ()))))",
    "(not abc)",
    "(not 1)",
    "(not (eq? 1 1))",
]

let inputSprint5 = [
    "(and? (= 1 1) (= 1 2))",
    "(and? (= 1 1) (= 3 3))",
    "(and? 1 ())",
    "(and? 1 10)",
    "(and? () ())",
    "(or? 1 1)",
    "(or? 1 ())",
    "(or? () ())",
    "(if (= 1 2) 1 2)",
    "(if (nil? abc) (+ 2 9) (* 2 9))",
    "(cond (= 1 2) 1 (= 1 1) 2 (= 29 29) 3)",
    "(cond (= 1 1) 1 (= 1 1) 2 ('t) 3)",
    "(set c (cons 12 (cons 13 (cons 14 ()))))",
    "(cond (eq? (car c) 13) 1 (> 2 5) 3 ('t) 5)",
    "(cond (eq? (car c) 12) 1 (> 2 5) 3 ('t) 5)",
    "(and? (eq? (car c) 12) (list? c))",
    "(if (number? (car c)) (* 10 9) (- 10 9))"
]

extension Yisp {
    func testSprint1() {
        for line in inputSprint4 {
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
    
    func testSprint4() {
        for line in inputSprint4 {
            let scanner = Scanner(source: line , errorReporting: self)
            let tokens = scanner.scanTokens()
            
            let parser = Parser(tokens: tokens, errorReporting: self)
            let sexpressions = parser.parse()
            guard(!hadError) else {return}
            
            for sexpr in sexpressions {
                print(sexpr.toString())
            }
            
            interpreter.interpret(sexpressions)
        }
    }
    
    func testSprint5() {
        for line in inputSprint5 {
            let scanner = Scanner(source: line , errorReporting: self)
            let tokens = scanner.scanTokens()
            
            let parser = Parser(tokens: tokens, errorReporting: self)
            let sexpressions = parser.parse()
            guard(!hadError) else {return}
            
            for sexpr in sexpressions {
                print(sexpr.toString())
            }
            
            interpreter.interpret(sexpressions)
        }
    }
}

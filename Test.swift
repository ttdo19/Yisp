//
//  Test.swift
//  Yisp
//
//  Created by Trang Do on 10/27/24.
//
import Foundation

let inputSprint4 : [String] = [
    // test cases for operators: eq? (or =), +, -, *, /, mod, <, <=, >=, >, '
    "(eq? 5 (+ 2 3))",
    "(eq? 2 (/ 6 (+ 2 1)))",
    "(eq? 18 (* 9 (/ 6 (+ 2 1))))",
    "(eq? 20 (- 38 (* 9 (/ 6 (+ 2 1)))))",
    "(eq? 21 (+ 1 (- 38 (* 9 (/ 6 (+ 2 1))))))",
    "(eq? 17 (/ (/ 510 3) 10))",
    "(eq? 1 1)",
    "(eq? (mod 10 3) 1)",
    "(eq? (+ (mod 10 3) 4) 5)",
    "(eq? (set a 3) 3)",
    "(eq? 23 (+ a (- 38 (* 9 (/ 6 (+ 2 1))))))",
    "(eq? (set pi 3.14) 3.14)",
    "(eq? 9.42 (* pi 3))",
    "(= (+ 20 30) 50)",
    "(= ('a) ('a))",
    "(< 10 (+ 7 5))",
    "(>= 2.89 1.29)",
    "(<= 290 (* 10 30))",
    "(> 2093 (* 20 100))",
    
    // test cases for commands set, number?, symbol?, list?, nil?, cons, car, cdr, not, ' (quote), eval
    "(eqlist? (set c (cons 1 (cons 2 (cons 3 ())))) (cons 1 (cons 2 (cons 3 ()))))",
    "(eq? (car c) (quote 1))",
    "(eq? 1 (eval(car c)))",
    "(eq? (set b 10) 10)",
    "(= b 10)",
    "(<= b 20)",
    "(eq? (set a 4) 4)",
    "(> b a)",
    "(eq? (car(cons 1 (cons 2 (cons 3 ())))) 1)",
    "(eqlist? (cdr(cons 1 (cons 2 (cons 3 ())))) (cons 2 (cons 3 ())))",
    "(eq? 29 (car(cons 29 (cons 30 ()))))",
    "(eqlist? (car(cons (cons 1 (cons 2 (cons 3 ()))) (cons 29 (cons 30 ())))) (cons 1 (cons 2 (cons 3 ()))))",
    "(eqlist? (cdr(cons (cons 1 (cons 2 (cons 3 ()))) (cons 29 (cons 30 ())))) (cons 29 (cons 30 ())))",
    "(nil? (car(cons () ())))",
    "(nil? (car(cons () (cons () ()))))",
    "(eq? 4 (car (cdr (cdr (cdr (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ()))))))))))",
    "(eqlist? (cons 5 ()) (cdr (cdr (cdr (cdr (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ()))))))))))",
    "(number? (+ 1 2))",
    "(not (number? ()))",
    "(nil? (number? (cons 1 (cons 2 (cons 3 ())))))",
    "(not (symbol? 289))",
    "(symbol? abc)",
    "(symbol? ('abc))",
    "(list? (cons 1 (cons 2 (cons 3 ()))))",
    "(nil? (list? 123))",
    "(list? ())",
    "(nil? (= () 1))",
    "(nil? (= () ()))",
    "(nil? ())",
    "(not (nil? 123))",
    "(not (nil? (cons 1 (cons 2 (cons 3 ())))))",
    "(not ())",
    "(nil? (not (cons 1 (cons 2 (cons 3 ())))))",
    "(nil? (not abc))",
    "(nil? (not 1))",
    "(not (not (eq? 1 1)))",
    "(eq? (eval(car(cons 1 (cons 2 (cons 3 ()))))) 1)",
    
]

let inputSprint5 = [
    // test cases for and?, or?, if, cond
    "(eq? 10 (set x 10))",
    "(and? (= 1 1) (= 10 x))",
    "(and? ('t) (= (* 10 3) 30))",
    "(not (and? 1 ()))",
    "(and? 1 10)",
    "(nil? (and? () ()))",
    "(or? 1 1)",
    "(or? 1 ())",
    "(nil? (or? () ()))",
    "(eq? 2 (if (= 1 2) 1 2))",
    "(eq? 18 (if (nil? abc) (+ 2 9) (* 2 9)))",
    "(eq? 2 (cond (= 1 2) 1 (= 1 1) 2 (= 29 29) 3))",
    "(eq? 1 (cond (= 1 1) 1 (= 1 1) 2 ('t) 3))",
    "(eqlist? (quote (12 13 14)) (set n (cons 12 (cons 13 (cons 14 ())))))",
    "(eq? 5 (cond (eq? (car n) 13) 1 (> 2 5) 3 ('t) 5))",
    "(eq? 1 (cond (eq? (car n) 12) 1 (> 2 5) 3 ('t) 5))",
    "(and? (eq? (car n) 12) (list? n))",
    "(eq? 90 (if (number? (car n)) (* 10 9) (- 10 9)))",
    "(eq? 10 (if (eq? () ()) (cons 10 ()) 10))"
]

let inputSprint6 = [
    "(EQ? mult3 (func mult3 (first second third) (* third (* first second))))",
    "(= 24 (mult3 2 3 4))",
    "(= add10 (func add10 (num) (+ num 10)))",
    "(= 30 (add10 20))",
    "(= 30 (set num 30))",
    "(= 90 (add10 80))",
    "(= 270 (mult3 (* 2 3) (- 8 3) (+ 4 5)))",
    "(= fib (func fib (n) (cond (< n 1) () (= n 1) 0 (= n 2) 1 ('t) (+ (fib (- n 1)) (fib (- n 2))))))",
    "(= 21 (fib 9))",
    "(= 4181 (fib 20))"
]

let inputforChallenges = [
    // test cases for using + (add, ADD, PLUS, plus), * (mul, MUL), - (sub, SUB), / (div, DIV) for more than 2 arguments
    "(= 46 (add 2 39 2 1 0 2))",
    "(= 46 (ADD 2 39 2 1 0 2))",
    "(= 46 (plus 2 39 2 1 0 2))",
    "(= 46 (PLUS 2 39 2 1 0 2))",
    "(= 46 (+ 2 39 2 1 0 2))",
    "(= 5040 (mul 1 2 3 4 5 6 7))",
    "(= 5040 (MUL 1 2 3 4 5 6 7))",
    "(= 5040 (* 1 2 3 4 5 6 7))",
    "(= 35 (sub 100 2 39 4 20))",
    "(= 35 (SUB 100 2 39 4 20))",
    "(= 35 (- 100 2 39 4 20))",
    "(= 3 (div 600 2 25 4))",
    "(= 3 (DIV 600 2 25 4))",
    "(= 3 (/ 600 2 25 4))",
    // test cases for using mod (MOD), = (eq?, EQ? ), < (lt, LT), > (gt, GT), <= (lte, LTE), >= (gte, GTE), nil? (null?, NULL?, NIL?)
    "(EQ? 1 (MOD 10 3))",
    "(lt 10 (+ 7 5))",
    "(LT 10 (+ 7 5))",
    "(gte 2.89 1.29)",
    "(GTE 2.89 1.29)",
    "(lte 290 (* 10 30))",
    "(LTE 290 (* 10 30))",
    "(gt 2093 (* 20 100))",
    "(GT 2093 (* 20 100))",
    "(NIL? (= () 1))",
    "(NULL? (= () ()))",
    // test cases for using ' (quote, QUOTE), list? (LIST?), symbol? (SYMBOL?), and? (AND?), or? (OR?), number? (NUMBER?), not (NOT), set (SET), cons (CONS)
    "(= 10 (SET k 10))",
    "(Nil? (SYMBOL? k))",
    "(SYMBOL? ('k))",
    "(SYMBOL? (quote k))",
    "(SYMBOL? (QUOTE k))",
    "(LIST? (cons 1 (cons 2 (cons 3 ()))))",
    "(AND? ('t) (= (* 10 3) 30))",
    "(OR? 1 ())",
    "(NIL? (NUMBER? (CONS 1 (CONS 2 (cons 3 ())))))",
    // test cases for car (CAR), cdr (CDR), cadr (CADR), caddr(CADDR), cadddr (CADDDR), if (IF), cond (COND), eval (EVAL), eqlist? (EQLIST?), atom? (ATOM?)
    "(EQ? 29 (CAR(CONS 29 (cons 30 ()))))",
    "(EQLIST? (CAR(cons (cons 1 (CONS 2 (cons 3 ()))) (CONS 29 (cons 30 ())))) (quote (1 2 3)))",
    "(EQLIST? (CDR(cons (cons 1 (cons 2 (CONS 3 ()))) (cons 29 (cons 30 ())))) (quote (29 30)))",
    "(= 2 (CADR (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ())))))))",
    "(= 3 (CADDR (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ())))))))",
    "(EQ? 4 (CADDDR (cons 1 (cons 2 (CONS 3 (cons 4 (cons 5 ())))))))",
    "(eq? 180 (IF (number? k) (* 10 9 2) (- 10 9 2)))",
    "(eq? 10 (IF (eq? () ()) (CONS 10 ()) 10))",
    "(eq? 2 (COND (= 1 2) 1 (= 1 1) 2 (= 29 29) 3))",
    "(eq? 1 (COND (= 1 1) 1 (= 1 1) 2 ('t) 3))",
    "(atom? (+ 2 1 19 8))",
    "(atom? m)",
    "(nil? (ATOM? (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 ())))))))",
    "(eq? (EVAL(car(cons 1 (cons 2 (cons 3 ()))))) 1)",
    "(EQ? 29 (EVAL(CAR(CONS 29 (cons 30 ())))))",
    // test cases for def (fun, fn, func, defun, define)
    "(= average2 (fn average2 (x y) (/ (+ x y) 2)))",
    "(= 85 (average2 90 80))",
    "(= list2 (fun list2 (x y) (cons x (cons y ()))))",
    "(eqlist? (list2 10 20) (quote (10 20)))",
    "(= list3 (defun list3 (x y z) (cons x (list2 y z))))",
    "(eqlist? (list3 10 20 30) (quote (10 20 30)))",
    // test cases for lambda
    "(= 14 ((lambda (a b c) (+ a b c)) 2 4 8))",
    "(= 11 ((lambda (a b c d) (+  (* a c) (+ (* b d)))) 1 2 3 4))",
    "(eqlist? (quote (a d)) ((lambda (x y) (cons (car x) y)) (quote (a b)) (cdr (quote (c d)))))",
    "(= 8 ((lambda (a b c) (* a b c)) 2 2 2))",
    "(= 7 ((lambda (a b c) (/ (+ a b c) 3)) 10 4 7))",
]

extension Yisp {
    func testSprint1() {
        print("Sprint 1 Testing")
        for line in inputSprint4 {
            let scanner = Scanner(source: line , errorReporting: self)
            let tokens = scanner.scanTokens()
            
            let parser = Parser(tokens: tokens, errorReporting: self)
            let sexpressions = parser.parse()
            guard(!hadError) else {return}
            
            // test scanner and parser
            for sexpr in sexpressions {
                print(sexpr.toString())
            }
        }
        print()
    }
    
    func testSprint2() {
        do {
            print("Sprint 2 Testing")
            print("Test 1:", terminator: " ")
            // ()
            if (Nil.toString() == "()") {
                print("Pass")
            } else {
                print("Fail")
            }

            print("Test 2:", terminator: " ")
            // T
            if (T.toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 3:", terminator: " ")
            // make atom symbol
            if ((atom("symbol").toString()) == "symbol") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 4:", terminator: " ")
            // make atom 411
            if ((atom("411").toString()) == "411") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 5:", terminator: " ")
            // make a list (one, two, three)
            if (try cons(atom("one"), try cons(atom("two"), try cons(atom("three"), Nil))).toString() == "(one two three)") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 6:", terminator: " ")
            // (car (first, second, third))
            if (try car(try cons(atom("first"), try cons(atom("second"), cons(atom("third"), Nil)))).toString() == "first") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 7:", terminator: " ")
            // (cdr (first, second, third))
            if (try cdr(try cons(atom("first"), try cons(atom("second"), try cons(atom("third"), Nil)))).toString() == "(second third)") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 8:", terminator: " ")
            // (list? (one two three))
            if (isList(try cons(atom("one"), try cons(atom("two"), try cons(atom("three"), Nil)))).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 9:", terminator: " ")
            // (atom? a)
            if (isAtom(atom("a")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 10:", terminator: " ")
            // (nil? ())
            if(isNil(Nil).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 11:", terminator: " ")
            // (symbol? 1289)
            if (isSymbol(atom("1289")).toString() == "()") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 12:", terminator: " ")
            // (number? 2197)
            if(isNumber(atom("2187")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 13:", terminator: " ")
            // (symbol? abc)
            if (isSymbol(atom("abc")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 14:", terminator: " ")
            // (nil? hello)
            if (isNil(atom("hello")).toString() == "()") {
                print("Pass")
            } else {
                print("Fail")
            }
            print()
        } catch let error as RuntimeError {
            self.runtimeError(error)
        } catch {
            let unexpectedError = RuntimeError.unexpected("Unexpected runtime error: \(error.localizedDescription)")
            self.runtimeError(unexpectedError)
        }
    }
    
    func testSprint3() {
        do {
            print("Sprint 3 Testing")
            print("Test 1:", terminator: " ")
            // (+ 2 3)
            if (String(describing: try add(try cons(atom("2"), cons(atom("3"), Nil)))) == "5") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 2:", terminator: " ")
            // (- 3 2)
            if (String(describing: try sub(try cons(atom("3"), cons(atom("2"), Nil)))) == "1") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 3:", terminator: " ")
            // (= 2 2)
            if (String(describing: try eq(atom("2"), atom("2")).toString()) == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 4:", terminator: " ")
            // (< 2 3)
            if (try lt(atom("2"), atom("3")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 5:", terminator: " ")
            // (>= 3 2)
            if (try gte(atom("3"), atom("2")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 6:", terminator: " ")
            // (* 2 3)
            if (String(describing: try mul(try cons(atom("2"), cons(atom("3"), Nil)))) == "6") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 7:", terminator: " ")
            // (* 15 3)
            if (String(describing: try mul(try cons(atom("15"), cons(atom("3"), Nil)))) == "45") {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 8:", terminator: " ")
            // (mod 25 3)
            if String(describing: try(mod(atom("25"), atom("3")))) == "1" {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 9:", terminator: " ")
            // (< 2 3)
            if (try lte(atom("6"), atom("9")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }

            print("Test 10:", terminator: " ")
            // (> 28 2)
            if (try gt(atom("28"), atom("2")).toString() == "T") {
                print("Pass")
            } else {
                print("Fail")
            }

            print("Test 11:", terminator: " ")
            // (not ())
            if (not(Nil).toString()) == "T" {
                print("Pass")
            } else {
                print("Fail")
            }

            print("Test 12:", terminator: " ")
            // (not 2187)
            if (not(atom("2187")).toString()) == "()" {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 13:", terminator: " ")
            // (not (1 2 3))
            if (not(try cons(atom("one"), try cons(atom("two"), try cons(atom("three"), Nil))))).toString() == "()" {
                print("Pass")
            } else {
                print("Fail")
            }
            
            print("Test 14:", terminator: " ")
            // (/ 15 3)
            if (String(describing: try div(try cons(atom("15"), cons(atom("3"), Nil)))) == "5") {
                print("Pass")
            } else {
                print("Fail")
            }
            print()
        } catch let error as RuntimeError {
            self.runtimeError(error)
 
        } catch {
            let unexpectedError = RuntimeError.unexpected("Unexpected runtime error: \(error.localizedDescription)")
            self.runtimeError(unexpectedError)

        }
    }
    
    func testSprint4() {
        print("Sprint 4 Testing")
        runTest(input: inputSprint4)
        print()
    }
    
    func testSprint5() {
        print("Sprint 5 Testing")
        runTest(input: inputSprint5)
        print()
    }
    
    func testSprint6() {
        print("Sprint 6 Testing")
        runTest(input: inputSprint6)
        print()
    }
    
    func testChallenges() {
        print("Testing for Challenges")
        runTest(input: inputforChallenges)
        print()
    }
    
    func runTest(input: [String]) {
        for lineNum in stride(from: 0, to: input.count, by: 1) {
            let scanner = Scanner(source: input[lineNum] , errorReporting: self)
            let tokens = scanner.scanTokens()
            
            let parser = Parser(tokens: tokens, errorReporting: self)
            let sexpressions = parser.parse()
            guard(!hadError) else {return}
            
//            for sexpr in sexpressions {
//                print(sexpr.toString())
//            }
            print("Test \(lineNum + 1):", terminator: " ")
            interpreter.interpret(sexpressions)
        }
    }
}

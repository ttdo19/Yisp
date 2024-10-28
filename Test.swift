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
}

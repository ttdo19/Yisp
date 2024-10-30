//
//  main.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/26/24.
//

import Foundation

public class Yisp: ErrorReporting{
    private(set) var hadError = false
    private(set) var hadRuntimeError = false
    let interpreter: Interpreter
    
    public func runFile(_ fileName: String) {
        do {
            let content = try String(contentsOfFile: fileName)
            run(content)
            if hadError {
                exit(EX_HAS_ERROR)
            }
            if hadRuntimeError {
                exit(EX_HAS_RUNTIME_ERROR)
            }
        } catch {
            print("Unable to read this file \(fileName): \(error.localizedDescription)")
            exit(EXIT_FAILURE)
        }
    }
    
    public init(hadError: Bool = false) {
        self.hadError = hadError
        self.interpreter = Interpreter()
        interpreter.errorReporting = self
    }
    
    public func runPrompt() {
        print(">")
        while true {
            guard let line = readLine() else {
                print("Unable to read input!")
                exit(EXIT_FAILURE)
            }
            if line.uppercased() == QUIT_COMMAND {
                break
            }
            run(line)
            hadError = false
        }
    }
    
    func run(_ source: String) {
        let scanner = Scanner(source: source, errorReporting: self)
        let tokens = scanner.scanTokens()
        
        let parser = Parser(tokens: tokens, errorReporting: self)
        let sexpressions = parser.parse()
        guard(!hadError) else {return}
        
//        for sexpr in sexpressions {
//            print(sexpr.toString())
//        }
        if (hadError) { return }
        
        interpreter.interpret(sexpressions)
    }
    
    func error (_ line: Int, _ message: String){
        report(line, "", message)
    }
    
    func report(_ line: Int, _ at: String, _ message: String){
        print("[line \(line)] Error \(at): \(message)")
        hadError = true
    }
    
    func error(at token: Token, message: String) {
        if (token.type == .eof) {
            report(token.line, " at end", message)
        } else {
            report(token.line, " at '\(token.lexeme)'", message)
        }
    }
    
    func runtimeError(_ runtimeError: RuntimeError) {
        switch runtimeError {
        case .undefinedVariable(let token, let message): fallthrough
        case .incorrectNumberArguments(let token, let message): fallthrough
        case .cannotGetProperty(let token, let message): fallthrough
        case .notCallable(let token, let message):
            error(at: token, message: message)
        case .mismatchedType(let message): fallthrough
        case .unexpected(let message):
            print(message)
        }
        hadRuntimeError = true
    }
}



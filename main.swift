//
//  main.swift
//  Yisp-Swift
//
//  Created by Trang Do on 10/26/24.
//

import Foundation

guard CommandLine.arguments.count < 3 else {
    print("Usage: yisp [script]")
    exit(EX_USAGE)
}

private let yisp = Yisp()

if CommandLine.arguments.count == 2 {
    yisp.runFile(CommandLine.arguments[1])
} else {
    yisp.runPrompt()
}

// Run tests
//yisp.testSprint1()
//yisp.testSprint2()
//yisp.testSprint3()
//yisp.testSprint4()
//yisp.testSprint5()

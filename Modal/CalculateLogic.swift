//
//  CalculateLogic.swift
//  Calculator
//
//  Created by jinqi on 2021/6/18.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation

struct CalculateLogic {
    private var number : Double? //can not be initialized
    static var isFinishedTypingNumber: Bool = true
    static var isPercentaged: Bool = false
    static var isDecimalUsed: Bool = false
    private var intermediateCalculation: (number: Double, operation: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculateButtonPressed(calSymbol : String) -> Double? {
        if let n = number {
            switch calSymbol {
            case "+/-":
                return n * -1
            case "AC":
                self.operationAC()
                return 0
            case "%":
                if(!CalculateLogic.isPercentaged) {
                    CalculateLogic.isPercentaged = true
                    return n * 0.01
                } else {
                    CalculateLogic.isPercentaged = false
                    return n * 100
                }
            case "=":
                guard let result = perfromTwoNumCalculation(secondNumber: n) else {
                    fatalError("The result of the calculation is nil")
                }
                self.intermediateCalculation = (number: result, operation: "=")
                self.operationAC()
                return result
            default:
                self.intermediateCalculation = (number: n, operation: calSymbol)
                self.operationAC()
                return n
            }
        }
        return nil
    }
    
    private func perfromTwoNumCalculation(secondNumber: Double) -> Double? {
        if let firstNum = intermediateCalculation?.number {
            let operation = intermediateCalculation?.operation
            switch operation {
            case "+":
                return firstNum + secondNumber
            case "-":
                return firstNum - secondNumber
            case "×":
                return firstNum * secondNumber
            case "÷":
                return firstNum / secondNumber
            default:
                return secondNumber
            }
        }
        return secondNumber
    }
    
    func operationAC() {
        CalculateLogic.isFinishedTypingNumber = true
        CalculateLogic.isPercentaged = false
        CalculateLogic.isDecimalUsed = false
    }
    
}

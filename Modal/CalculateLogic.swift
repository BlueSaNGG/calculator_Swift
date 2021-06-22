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
    //tuple to store 2 elements
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
            case "+":
                self.intermediateCalculation = (number: n, operation: "+")
                self.operationAC()
                return n
            case "-":
                self.intermediateCalculation = (number: n, operation: "-")
                self.operationAC()
                return n
            case "×":
                self.intermediateCalculation = (number: n, operation: "*")
                self.operationAC()
                return n
            case "÷":
                self.intermediateCalculation = (number: n, operation: "/")
                self.operationAC()
                return n
            case "=":
                if let finalCal = self.intermediateCalculation {
                    let result = perfromTwoNumCalculation(finalCal, secondNumber: n)
                    self.intermediateCalculation = (number: result, operation: "=")
                    return result
                }
                
            default:
                return 0
            }
        }
        return nil
    }
    
    func perfromTwoNumCalculation(_ finalCal : (number: Double, operation: String), secondNumber: Double) -> Double {
        var firstNum = finalCal.number
        switch finalCal.operation {
        case "+":
            firstNum += secondNumber
        case "-":
            firstNum -= secondNumber
        case "*":
            firstNum *= secondNumber
        case "/":
            firstNum /= secondNumber
        default:
            break
        }
        return firstNum
    }
    
    func operationAC() {
        CalculateLogic.isFinishedTypingNumber = true
        CalculateLogic.isPercentaged = false
        CalculateLogic.isDecimalUsed = false
    }
    
}

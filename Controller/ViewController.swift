//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit    //include Foundation + UIelements

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    //computed property
    private var displayValue : Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot conver display label text to a Double!")
            }
            return number
        }
        
        set {
            displayLabel.text = truncateZeroToString(number: newValue)
        }
    }
    
    private var calculator = CalculateLogic();
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        if let calSymbol = sender.currentTitle {
            calculator.setNumber(displayValue)
            guard let result = calculator.calculateButtonPressed(calSymbol: calSymbol) else {
                fatalError("calculate result are not readable.")
            }
            displayValue =  result
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let numVal = sender.currentTitle {
            
            if(CalculateLogic.isFinishedTypingNumber) {
                let numString = displayLabel.text
                if(numString == "-0") {
                    if numVal == "." {
                        displayLabel.text = "-0."
                        CalculateLogic.isDecimalUsed = true
                    } else if(numVal == "0") {
                        return
                    } else {
                        displayLabel.text = "-" + numVal
                    }
                } else if (numString == "0") {
                    if numVal == "." {
                        displayLabel.text = "0."
                        CalculateLogic.isDecimalUsed = true
                    } else if(numVal == "0") {
                        return
                    } else {
                        displayLabel.text = numVal
                    }
                } else {
                    displayLabel.text = numVal
                }
                CalculateLogic.isFinishedTypingNumber = false
            } else {
                if numVal == "." {
                    //判断当前数值是否是整数，是则可加小数点，不是则不可加小数点
                    if (CalculateLogic.isDecimalUsed) {
                        return
                    }
                    CalculateLogic.isDecimalUsed = true
                }
                displayLabel.text?.append(numVal)
            }
            
            
        }
    }
    
    private func truncateZeroToString(number : Double) -> String {
        return number.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", number) : String(number)
    }
}


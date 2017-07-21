//
//  ViewController.swift
//  Calculator
//
//  Created by Anne Li on 6/14/17.
//  Copyright © 2017 a(nne)pple. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    
    
    //set to private; more maintainable and secure
    private var userIsInTheMiddleOfTyping = false  //stored variable
    private var displayValue: Double {  //computed variable
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()
    
    
    
    @IBOutlet private weak var display: UILabel!
    
    
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        let mathematicalSymbol = sender.currentTitle!
        brain.performOperation(symbol: mathematicalSymbol)
        displayValue = brain.result
    }
    
    
    
}


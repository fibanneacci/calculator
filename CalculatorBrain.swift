//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Anne Li on 6/14/17.
//  Copyright © 2017 a(nne)pple. All rights reserved.
//



//  NEVER IMPORT UIKIT IN MODEL FILE, MODEL IS UI-INDEPENDENT!

import Foundation

class CalculatorBrain {
    
    
    
    private var accumulator = 0.0
    
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    
    
    private var pending: PendingBinaryOperationInfo?
    
    
    
    private struct PendingBinaryOperationInfo {  //NOTE: read more on differences betweens structs and classes
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    
    
    private enum Operation {  //operations' structures
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Clear
        case DecimalPoint
        case Equals
    }
    
    
    
    private var operations: Dictionary < String, Operation> = [  //specific operations
        "π"     : Operation.Constant(Double.pi),
        "e"     : Operation.Constant(M_E),
        
        "√"     : Operation.UnaryOperation(sqrt),
        "log"   : Operation.UnaryOperation(log10),
        "ln"    : Operation.UnaryOperation(log),
        "sin"   : Operation.UnaryOperation(sin),
        "cos"   : Operation.UnaryOperation(cos),
        "tan"   : Operation.UnaryOperation(tan),
        "(-)"   : Operation.UnaryOperation({ -$0 }),
        
        "+"     : Operation.BinaryOperation({ $0 + $1 }),
        "-"     : Operation.BinaryOperation({ $0 - $1 }),
        "x"     : Operation.BinaryOperation({ $0 * $1 }),
        "÷"     : Operation.BinaryOperation({ $0 / $1 }),
        
        "C"     : Operation.Clear,
        
        "."     : Operation.DecimalPoint,
        
        "="     : Operation.Equals
        ]
    
    
    
    func performOperation(symbol: String) {  //performs operations
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Clear:
                accumulator = 0.0
            case .DecimalPoint:  //NOTE: need to fix! Doesn't work.
                if (String(accumulator).contains(".")) {
                    break
                } else {
                    accumulator = Double((String(accumulator)) + ".")!
                }
            case .Equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                }
            }
        }
    }
    
    
    
    var result: Double {  //returns result
        get {
            return accumulator
        }
    }
    
    
}

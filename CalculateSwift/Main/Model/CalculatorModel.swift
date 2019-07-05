//
//  CalculatorModel.swift
//  CalculateSwift
//
//  Created by Wswy on 2019/6/25.
//  Copyright © 2019 王云晨. All rights reserved.
//


import Foundation

struct CalculatorModel {
    private(set) var result:Double? {
        didSet {
            if result != nil {
                operand = result
            }
        }
    }
    
    private var operand: Double?
    
    private var pendingOperation:PendingBinaryOperation?
    
    
    mutating func performOperation(_ symbol:String) {
        let operation = operations[symbol]
        switch operation {
        case .some(.constant(let value)):
            result = value
            pendingOperation = nil
        case .some(.unary(let function)):
            if operand != nil {
                result = function(operand!)
            }
        case .some(.binary(let function)):
            if operand != nil {
                pendingOperation = PendingBinaryOperation(firstOperand: operand!, operation: function)
            }
        case .some(.equal):
            if pendingOperation != nil && operation != nil {
                result = pendingOperation?.perform(with: operand!)
            }
        case .none:
            break
        }
    }
    
    mutating func getResult () {
        if pendingOperation != nil {
            result = pendingOperation?.perform(with: operand!)
        }
    }
    
    mutating func setOperand(_ operand:Double) {
        self.operand = operand
        result = operand
    }
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let operation: (Double, Double) -> Double
        func perform(with secoundOperand:Double) -> Double {
            return operation(firstOperand,secoundOperand)
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double,Double) -> Double)
        case equal
    }
    
    private var operations:[String:Operation] = [
        "AC":   .constant(0),   // 清空，直接返回0
        "±" :   .unary({-$0}),
        "%" :   .unary({$0 / 100}),
        "+" :   .binary( + ),
        "−" :   .binary( - ),
        "×" :   .binary( * ),
        "/" :   .binary( / ),
        "=" :   .equal,
    ]
}

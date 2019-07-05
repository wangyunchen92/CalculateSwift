//
//  MainViewController.swift
//  CalculateSwift
//
//  Created by Wswy on 2019/5/22.
//  Copyright © 2019 王云晨. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController   {
    @IBOutlet weak var displayValueLabel: UILabel!
    @IBOutlet weak var numStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var horizontalView: UIView!
    
    @IBOutlet weak var writhView: WrithAdimationView!
    @IBOutlet weak var horizontalWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var numStackViewRightConstraint: NSLayoutConstraint!
    var displayValue:Double {
        get {
            return Double(displayValueLabel.text!)!
        }
        set {
            if Double(Int(newValue)) == newValue {
                displayValueLabel.text = String(Int(newValue))
            } else {
                displayValueLabel.text = String(newValue)
            }
        }
    }
    
    var brain = CalculatorModel()
    
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }
    
    @IBOutlet var digitsButtons: [CalculateDigitButton]!
    
    @IBOutlet var operationsButtons: [CalculateDigitButton]!
    
    var userIsIntyping:Bool = false
    
    override func viewDidLoad() {
        for (_,item) in self.digitsButtons.enumerated() {
            item.addTarget(self, action: #selector(MainViewController.DigitsButtonTouch(button:)), for: UIControl.Event.touchDown)
        }
        for (_,item) in self.operationsButtons.enumerated() {
            item.addTarget(self, action: #selector(MainViewController.OperationButtonTouch(button:)), for: UIControl.Event.touchDown)
        }
        KAppdelegate?.isBlockRotation = true
        
        // 没有生成通知
        if !UIDevice.current.isGeneratingDeviceOrientationNotifications {
            // 生成通知
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }
        
        // 锁定竖屏,依然有效,例如faceUp.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleDeviceOrientationChange(notification:)),
                                               name:UIDevice.orientationDidChangeNotification,
                                               object: nil)
        
    }
    
    @objc func DigitsButtonTouch(button:CalculateDigitButton) {
        let digit = button.currentTitle!
        let textCurrentInDisplay = displayValueLabel.text!

        if userIsIntyping {
            if digit == "0" && textCurrentInDisplay == "0" {
                displayValueLabel.text = "0"
            }
            else {
                
                if digit == "." && textCurrentInDisplay.contains(".") {
                    return
                }
                displayValueLabel.text = textCurrentInDisplay + digit
            }
        }
        else {
            if digit == "." {
                displayValueLabel.text = "0."
            }
            else {
                displayValueLabel.text = digit
            }
            userIsIntyping = true
        }
        self.writhView.path = ToolUtil.transform(toBezierPath: self.displayValueLabel.text)
        self.writhView.state = .firstNum
        self.writhView.setNeedsDisplay()
    }
    
    @objc func OperationButtonTouch(button:UIButton) {
        // 1. 设置操作数
        self.writhView.calculatorCode = ToolUtil.transform(toBezierPath: button.currentTitle!)
        self.writhView.state = .code
        self.writhView.setNeedsDisplay()
        if self.userIsIntyping {
            brain.setOperand(displayValue)
            brain.getResult()
            // 设置完错作符之后，需要接受第二个操作数
            self.userIsIntyping = false
        }
        // 2.执行计算
        brain.performOperation(button.currentTitle!)
        
        // 3.获取结果
        if let result = brain.result {
            displayValue = result
        }
    }
    

    
    @objc private func handleDeviceOrientationChange(notification: Notification) {
        let device = UIDevice.current
        switch device.orientation {
        case .portrait:
            print("垂直向下")
            self.numStackViewWidth.constant = -20
//            self.horizontalWidthConstraint.constant = 0
            self.numStackViewRightConstraint.constant = 10
            self.horizontalView.alpha = 0
        case .landscapeLeft:
             print("垂直向左")
            self.numStackViewWidth.constant = -(kScreenWidth / 7 * 5 + 20)
             self.numStackViewRightConstraint.constant = 10
             self.horizontalWidthConstraint.constant = -(kScreenWidth / 7 * 2 + 40)
            self.horizontalView.alpha = 1
            
        case .landscapeRight:
             print("垂直向右")
            self.numStackViewWidth.constant = -(kScreenWidth / 7 * 5 + 20)
             self.numStackViewRightConstraint.constant = 10 + 22
             self.horizontalWidthConstraint.constant = -(kScreenWidth / 7 * 2 + 40)

            self.horizontalView.alpha = 1
        default:
            break
        }
    }

}

extension MainViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


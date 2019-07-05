//
//  WrithAdimationView.swift
//  CalculateSwift
//
//  Created by Wswy on 2019/7/4.
//  Copyright © 2019 王云晨. All rights reserved.
//

import UIKit


class WrithAdimationView: UIView {
    
    enum WrithState {
        case firstNum
        case code
        case secendNum
        case result
    }

    var path = ToolUtil.transform(toBezierPath: "I'm Quinn")
    var pathLayer = CAShapeLayer.init()
    var calculatorCode = ToolUtil.transform(toBezierPath: "")
    var calculatorLayer = CAShapeLayer.init()
    var state = WrithState.firstNum
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        switch  self.state {
        case .firstNum:
            self.pathLayer.removeFromSuperlayer()
            self.creatPenShaperLayer()
        case .code:
            self.creatCodeShaperLayer()
        default:
            break
        }
    }
    
    func creatPenShaperLayer () {
        pathLayer.bounds = self.path!.cgPath.boundingBoxOfPath
        pathLayer.frame = CGRect(x: self.frame.width - self.path!.cgPath.boundingBoxOfPath.width - 5 , y: 0 + self.path!.cgPath.boundingBoxOfPath.height , width: 0, height: 0)
        pathLayer.backgroundColor = UIColor.yellow.cgColor;
        pathLayer.isGeometryFlipped = true;
        pathLayer.path = self.path!.cgPath;
        pathLayer.strokeColor = RGBCOLOR(r: 234, 84, 87).cgColor
        pathLayer.fillColor = UIColor.clear.cgColor;
        pathLayer.lineWidth = 1;
        pathLayer.strokeColor = UIColor.black.cgColor;
        pathLayer.lineJoin = CAShapeLayerLineJoin.round;
        self.layer.addSublayer(pathLayer)
        self.addAnimation(layer: pathLayer)
    }
    
    func creatCodeShaperLayer() {
        calculatorLayer.bounds = self.calculatorCode!.cgPath.boundingBoxOfPath
        calculatorLayer.frame = CGRect(x: self.frame.width - self.calculatorCode!.cgPath.boundingBoxOfPath.width - 5 , y: 0 + self.calculatorCode!.cgPath.boundingBoxOfPath.height + 10 +  self.path!.cgPath.boundingBoxOfPath.height  , width: 0, height: 0)
        calculatorLayer.backgroundColor = UIColor.yellow.cgColor;
        calculatorLayer.isGeometryFlipped = true;
        calculatorLayer.path = self.calculatorCode!.cgPath;
        calculatorLayer.strokeColor = RGBCOLOR(r: 234, 84, 87).cgColor
        calculatorLayer.fillColor = UIColor.clear.cgColor;
        calculatorLayer.lineWidth = 1;
        calculatorLayer.strokeColor = UIColor.black.cgColor;
        calculatorLayer.lineJoin = CAShapeLayerLineJoin.round;
        self.layer.addSublayer(calculatorLayer)
        self.addAnimation(layer: calculatorLayer)
    }
    
    func addAnimation(layer:CAShapeLayer) {
        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = 1.0;
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        layer.add(pathAnimation, forKey: "strokeStart")
        pathAnimation.speed = 0.1;
        pathAnimation.timeOffset = 0;
    }

}


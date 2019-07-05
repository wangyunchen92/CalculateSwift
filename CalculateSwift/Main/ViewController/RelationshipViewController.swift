//
//  RelationshipViewController.swift
//  CalculateSwift
//
//  Created by Wswy on 2019/6/25.
//  Copyright © 2019 王云晨. All rights reserved.
//

import UIKit
import JavaScriptCore


class RelationshipViewController: UIViewController {

    
    @IBOutlet weak var fatherBtn: CalculateRelationshipButton!
    @IBOutlet weak var motherBtn: CalculateRelationshipButton!
    
    @IBOutlet weak var husbandBtn: CalculateRelationshipButton!
    @IBOutlet weak var wifeBtn: CalculateRelationshipButton!
    @IBOutlet weak var sonBtn: CalculateRelationshipButton!
    @IBOutlet weak var daughterBtn: CalculateRelationshipButton!
    @IBOutlet weak var brotherBtn: CalculateRelationshipButton!
    @IBOutlet weak var youngerBrotherBtn: CalculateRelationshipButton!
    @IBOutlet weak var sisterBtn: CalculateRelationshipButton!
    @IBOutlet weak var youngerSisterBtn: CalculateRelationshipButton!
    @IBOutlet weak var clearEntryBtn: CalculateRelationshipButton!
    @IBOutlet weak var allClearBtn: CalculateRelationshipButton!
    @IBOutlet weak var convertBtn: CalculateRelationshipButton!
    @IBOutlet weak var equalBtn: CalculateRelationshipButton!
    
    private var jsContext: JSContext? {
        guard let jsContext = JSContext(),
            let hgPath = Bundle.main.path(forResource: "relationship.min", ofType: "js"),
            let js = try? String(contentsOfFile: hgPath)
            else { return nil }
        
        let _ = jsContext.evaluateScript(js)
        return jsContext
    }
    
    private var relatives: [String] = [] {
        didSet {
            
            let text = relatives.joined(separator: "的")
            if text.isEmpty {
                enterLabel.text = ""
                resultLabel.text = "自己"
                return
            }
            
            enterLabel.text = text//.isEmpty ? "我" : text
            
            
            if ["妈妈", "老婆", "女儿", "姐姐", "妹妹"].contains(relatives.last ?? "")  {
                wifeBtn.isEnabled = false
                husbandBtn.isEnabled = true
            } else {
                wifeBtn.isEnabled = true
                husbandBtn.isEnabled = false
            }
            
            if relatives.count > 15 {
                resultLabel.text = "关系有点远，年长就叫老祖宗吧~"
                return
            }
            
            relationship(text: text)
        }
    }
    
    private var isNight = false {
        didSet {
            updateTheme()
        }
    }
    
    @IBOutlet weak var enterLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .orange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "night"), style: .plain, target: self, action: #selector(switchTheme))
        
   
        UIView.activate(constraints: [fatherBtn.heightAnchor.constraint(equalTo: fatherBtn.widthAnchor)])
        
        [resultLabel, enterLabel].forEach { $0.adjustsFontSizeToFitWidth = true }
        
        isNight = UserDefaults.standard.bool(forKey: "isNight")
//        self.fatherBtn.addTarget(self, action: #selector(self.tapKeyAction(_:)), for: UIControl.Event.touchDown)
    }
    
    
    @IBAction func tapKeyAction(_ btn: CalculateRelationshipButton) {
        guard let text = btn.currentTitle, text.count > 0,
            let relation = convertToRelation(text: text) else { return }
        relatives.append(relation)
    }
    
    private func renewBtnState() {
        wifeBtn.isEnabled = true
        husbandBtn.isEnabled = true
    }
    
    @IBAction func tapFunctionKeyAction(_ btn: CalculateRelationshipButton) {
        switch btn {
        case clearEntryBtn:
            if relatives.count > 0 {
                renewBtnState()
                relatives.removeLast()
            }
        case allClearBtn:
            renewBtnState()
            relatives.removeAll()
        case convertBtn:
            convertBtn.isSelected.toggle()
            convertBtn.imageView?.tintColor = convertBtn.isSelected ? .white : .black
            refreshRelative()
        case equalBtn:
            refreshRelative()
        default:
            break
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isNight ? .lightContent : .default
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension RelationshipViewController {
    
    private func refreshRelative() {
        let res = relatives
        relatives = res
    }
    
    /// text: 输入的文本
    /// sex: 自己的性别：0女性,1男性
    /// reverse: 称呼方式：true对方称呼我,false我称呼对方
    private func relationship(text: String) {
        let reverse = convertBtn.isSelected
        //        let sex: Sex = labelSwitch.curState == .L ? .man : .woman
        let script = "relationship({text: '\(text)', sex: \(-1), type: 'default', reverse: \(reverse ? "true" : "false")})"
        let res = jsContext?.evaluateScript(script).toString()
        resultLabel.text = res
        
        if res?.isEmpty == true {
            resultLabel.text = "貌似他/她跟你不是很熟哦!"
        }
    }
    
    private func convertToRelation(text: String) -> String? {
        switch text {
        case "父":
            return "爸爸"
        case "母":
            return "妈妈"
        case "夫":
            return "老公"
        case "妻":
            return "老婆"
        case "子":
            return "儿子"
        case "女":
            return "女儿"
        case "兄":
            return "哥哥"
        case "弟":
            return "弟弟"
        case "姐":
            return "姐姐"
        case "妹":
            return "妹妹"
        default:
            return nil
        }
    }
    
    @objc private func switchTheme() {
        isNight = !isNight
    }
    
    private func updateTheme() {
        UserDefaults.standard.set(isNight, forKey: "isNight")
        UserDefaults.standard.synchronize()
        
        UIView.animate(withDuration: 0.1) {
            self.view.backgroundColor = self.isNight ? #colorLiteral(red: 0.02745098039, green: 0.06666666667, blue: 0.08235294118, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            [self.fatherBtn, self.motherBtn, self.husbandBtn, self.wifeBtn, self.sonBtn, self.daughterBtn,
             self.brotherBtn, self.youngerBrotherBtn, self.sisterBtn, self.youngerSisterBtn,
             self.clearEntryBtn, self.allClearBtn, self.convertBtn, self.equalBtn
                ].forEach { $0?.colorTheme = self.isNight ? .night : .day }
            
            self.resultLabel.textColor = self.isNight ? .white : .black
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}

enum Sex: Int {
    case woman = 0
    case man
}


extension UIView {

    static func activate(constraints: [NSLayoutConstraint]) {
        constraints.forEach { ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate(constraints)
    }

    func pin(to view: UIView, insets: UIEdgeInsets = .zero) {
        UIView.activate(constraints: [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)
            ])
    }

    func center(in view: UIView, offset: UIOffset = .zero) {
        UIView.activate(constraints: [
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.horizontal),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.vertical)
            ])
    }

}


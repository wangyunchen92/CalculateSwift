//
//  CalculateDigitButton.swift
//  CalculateSwift
//
//  Created by Wswy on 2019/6/25.
//  Copyright © 2019 王云晨. All rights reserved.
//

import UIKit

class CalculateDigitButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height * 0.5
        layer.masksToBounds = true
    }

}

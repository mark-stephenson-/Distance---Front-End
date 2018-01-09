//
//  Extensions.swift
//  NHS Prase
//
//  Created by Anh Phan Tran on 1/9/18.
//  Copyright © 2018 The Distance. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    /// EZSwiftExtensions
    public func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
    }
}

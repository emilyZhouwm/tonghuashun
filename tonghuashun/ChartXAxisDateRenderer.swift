//
//  ChartXAxisDateRenderer.swift
//  tonghuashun
//
//  Created by 周粥 on 2019/5/16.
//  Copyright © 2019 周文敏. All rights reserved.
//

import Foundation
import UIKit
import Charts

open class ChartXAxisDateRenderer: XAxisRenderer {
    open override func computeAxisValues(min: Double, max: Double)
    {
        computeSize()
    }
}

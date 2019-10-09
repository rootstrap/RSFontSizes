//
//  Size.swift
//  RSFontSizes
//
//  Created by Rootstrap on 3/28/19.
//

import Foundation
import UIKit
import Device

extension Size {
  static let current: Size = Device.size()
  public static let all: [Size] = [screen3_5Inch, screen4Inch, screen4_7Inch,
                                   screen5_5Inch, screen5_8Inch, screen6_1Inch,
                                   screen6_5Inch, screen7_9Inch, screen9_7Inch,
                                   screen10_5Inch, screen12_9Inch]
  
  func proportion(to base: Size) -> CGFloat {
    return inches/base.inches
  }
  
  public var inches: CGFloat {
    switch self {
    case .screen3_5Inch: return 3.5
    case .screen4Inch: return 4
    case .screen4_7Inch: return 4.7
    case .screen5_5Inch: return 5.5
    case .screen5_8Inch: return 5.8
    case .screen6_1Inch: return 6.1
    case .screen6_5Inch: return 6.5
    case .screen7_9Inch: return 7.9
    case .screen9_7Inch: return 9.7
    case .screen10_5Inch: return 10.5
    case .screen12_9Inch: return 12.9
    default: return 12.9
    }
  }
  
  public var closer: Size {
    switch self {
    case .screen3_5Inch: return .screen4Inch
    case .screen4Inch: return .screen3_5Inch
    case .screen4_7Inch: return .screen5_5Inch
    case .screen5_5Inch: return .screen4_7Inch
    case .screen5_8Inch: return .screen5_5Inch
    case .screen6_1Inch: return .screen5_8Inch
    case .screen6_5Inch: return .screen6_1Inch
    case .screen7_9Inch: return .screen9_7Inch
    case .screen9_7Inch: return .screen7_9Inch
    case .screen10_5Inch: return .screen9_7Inch
    case .screen12_9Inch: return .screen10_5Inch
    default: return self
    }
  }
}

//
//  PointSize.swift
//  RSFontSizes
//
//  Created by Rootstrap on 3/28/19.
//

import Device
import UIKit

public enum PointSize {
  //Predefined sizes
  case tiny
  case small
  case normal
  case medium
  case big
  case huge
  case enormous
  case fixed(points: CGFloat)
  
  //Screen size adaptive
  case specific(with: SizeSpecification)
  case proportional(to: BaseSize)
  
  var value: CGFloat {
    switch self {
    case .tiny: return 8
    case .small: return 12
    case .normal: return 16
    case .medium: return 20
    case .big: return 24
    case .huge: return 32
    case .enormous: return 40
    case .fixed(let value): return value
      
    //Calculates proportional font sizes from a base size in the given screen size
    case .proportional(let baseSize):
      return baseSize.1 * Size.current.proportion(to: baseSize.0)
      
      //Returns the correct font size from the consumer specifics
      //If no specification found for the current screen size the estimated font size is:
      //The consumer specification for the closer screen size
    //Or the proportional size calculated with one of the provided specifications
    case .specific(let specifics):
      guard !specifics.isEmpty else {
        return Font.defaultSize * Size.current.proportion(to: .screen3_5Inch)
      }
      if let value = specifics[Size.current] ?? specifics[Size.current.closer] {
        return value
      }
      let base = specifics.first!
      return base.value * Size.current.proportion(to: base.key)
    }
  }
}

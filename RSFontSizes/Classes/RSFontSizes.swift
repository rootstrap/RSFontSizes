//
//  FontSizes.swift
//  FontSizes
//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Rootstrap Inc

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import UIKit

public typealias SizeSpecification = [Size: CGFloat]
public typealias BaseSize = (Size, CGFloat)

public class Font {
  static var defaultSize: CGFloat = 12
  internal static var predefined: [UIFontTextStyle: UIFont] = [:]
  
  public enum PointSize {
    //Fixed sizes
    case tiny
    case small
    case normal
    case medium
    case big
    case huge
    case enormous
    case fixed(CGFloat)
    
    //Screen size adaptive
    case specific(with: SizeSpecification)
    case proportional(to: BaseSize)
    
    public func value() -> CGFloat {
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
        if let value = specifics[Size.current] ?? specifics[Size.current.closer()] {
          return value
        }
        let base = specifics.first!
        return base.value * Size.current.proportion(to: base.key)
      }
    }
  }
  
  public enum Style: String {
    case thin = "Thin"
    case light = "Light"
    case extraLight = "ExtraLight"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case black = "Black"
    case italic = "Italic"
    
    //Possible similar styles with preferences
    func alternatives() -> [Style] {
      switch self {
      case .thin: return [.extraLight, .light]
      case .light: return [.thin, .extraLight]
      case .extraLight: return [.thin, .light]
      case .regular: return [.medium]
      case .medium: return [.regular]
      case .semibold: return []
      case .bold: return [.semibold, .extraBold, .black]
      case .extraBold: return [.black, .bold]
      case .black: return [.extraBold, .bold]
      default: return []
      }
    }
  }
  
  //MARK TypeFont Generation

  // Fonts should be added and correctly linked to the project.
  // Note: If there are too many in your project I would recommend FontBlaster pod.
  class func find(family name: String, style: Font.Style) -> String {
    let families = UIFont.familyNames
    guard let family = families.filter({ $0 == name }).first else {
      print("No Font family found with name \(name)")
      return name
    }
    
    let fonts = UIFont.fontNames(forFamilyName: family)
    let desired = String(describing: "\(name)-\(style.rawValue)")
    if let name = fonts.filter({$0 == desired}).first {
      return name
    }else {
      //Look for similar font styles according to FontStyle.alternatives:
      for altern in style.alternatives() {
        let similar = String(describing: "\(name)-\(altern.rawValue)")
        if let alterName = fonts.filter({$0 == similar}).first {
          print("No Font found with name \(desired). Using \(alterName) instead.")
          return alterName
        }
      }
      print("No \(desired) variant found in family \(family)")
      return name
    }
  }
  
  //TODO: Add font descriptor generator for multiple styles
  
  //MARK Preferences
  
  public static func with(class style: UIFontTextStyle) -> UIFont? {
    return predefined[style]
  }
  
  public static func save(font: UIFont?, forClass style: UIFontTextStyle) {
    predefined[style] = font
  }
}

//MARK: Utility Extensions

extension String {
  public func with(style: Font.Style = .regular, size: Font.PointSize = .normal) -> UIFont? {
    guard !isEmpty else { return nil }
    return UIFont(name: Font.find(family: self, style: style), size: size.value()) ?? UIFont.systemFont(ofSize: size.value())
  }
}

extension Size {
  
  static let current: Size = Device.size()
  
  func proportion(to base: Size) -> CGFloat {
    return rawValue/base.rawValue
  }
  
  func closer() -> Size {
    switch self {
    case .screen3_5Inch: return .screen4Inch
    case .screen4Inch: return .screen3_5Inch
    case .screen4_7Inch: return .screen5_5Inch
    case .screen5_5Inch: return .screen4_7Inch
    case .screen7_9Inch: return .screen9_7Inch
    case .screen9_7Inch: return .screen7_9Inch
    case .screen10_5Inch: return .screen9_7Inch
    case .screen12_9Inch: return .screen10_5Inch
    default: return self
    }
  }
}

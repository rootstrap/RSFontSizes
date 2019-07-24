//
//  RSFontSizes.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Rootstrap Inc

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import UIKit
import Device

public typealias SizeSpecification = [Size: CGFloat]
public typealias BaseSize = (Size, CGFloat)

public class Font {
  static var defaultSize: CGFloat = 12
  internal static var predefined: [UIFont.TextStyle: UIFont] = [:]
  
  @available(iOS 8.2, *)
  class func with(familyName name: String,
                  weight: UIFont.Weight,
                  size: PointSize) -> UIFont {
    return UIFont(familyName: name, weight: weight, size: size)
  }
  
  //MARK UIFontDescriptor matching
  
  class func bestDescriptor(matchingAttributes attributes: [UIFontDescriptor.AttributeName: Any],
                            weight: UIFont.Weight) -> UIFontDescriptor {
    var bestDescriptor = UIFontDescriptor(fontAttributes: attributes)
    let faces = faceNames(fromWeight: weight)
    faceSearch: for face in faces {
      let baseDescriptor = bestDescriptor.addingAttributes([.face: face])
      if let descriptor = exactMatch(from: baseDescriptor, mandatoryKeys: [.family, .face]) {
        bestDescriptor = descriptor
        break faceSearch
      }
      if let lessAccurateDescriptor = exactMatch(from: baseDescriptor, mandatoryKeys: [.family, .traits]) {
        bestDescriptor = lessAccurateDescriptor
        break faceSearch
      }
    }
    
    return bestDescriptor
  }
  
  private class func exactMatch(from descriptor: UIFontDescriptor,
                                mandatoryKeys: Set<UIFontDescriptor.AttributeName>) -> UIFontDescriptor? {
    let matchingDescriptors = descriptor.matchingFontDescriptors(withMandatoryKeys: mandatoryKeys)
    if let descriptor = matchingDescriptors.first, matchingDescriptors.count == 1 {
     return descriptor
    }
    return nil
  }
  
  private class func faceNames(fromWeight weight: UIFont.Weight) -> [String] {
    return ([weight] + similarWeights(forWeight: weight)).map { $0.faceName }
  }
  
  private class func similarWeights(forWeight weight: UIFont.Weight) -> [UIFont.Weight] {
    switch weight {
    case .extraLight: return [.ultraLight, .thin]
    case .ultraLight: return [.extraLight, .thin]
    case .thin: return [.ultraLight,  .extraLight]
    case .book: return [.demi, .light]
    case .demi: return [.book, .light]
    case .light: return [.book, .demi]
    case .normal: return [.regular, .medium]
    case .regular: return [.medium, .normal]
    case .medium: return [.regular, .normal, .semibold]
    case .demibold: return [.semibold, .medium, .bold]
    case .semibold: return [.medium, .demibold, .bold]
    case .bold: return [.semibold, .demibold]
    case .extraBold: return [.black, .heavy, .bold]
    case .heavy: return [.black, .extraBold, .bold]
    case .black: return [.heavy, .extraBold, .bold]
    case .extraBlack: return [.ultraBlack, .fat, .poster, .black]
    case .ultraBlack: return [.extraBlack, .fat, .poster, .black]
    case .fat: return [.extraBlack, .ultraBlack, .poster, .black]
    case .poster: return [.extraBlack, .ultraBlack, .fat, .black]
    default: return []
    }
  }
  
  //MARK Preferences
  
  public static func with(class style: UIFont.TextStyle) -> UIFont? {
    return predefined[style]
  }
  
  public static func save(font: UIFont?, forClass style: UIFont.TextStyle) {
    predefined[style] = font
  }
}

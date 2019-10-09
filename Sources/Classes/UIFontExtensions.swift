//
//  UIFontExtensions.swift
//  Device
//
//  Created by German on 3/28/19.
//

import UIKit

@available(iOS 8.2, *)
public extension UIFont {
  convenience init(familyName: String,
                   weight: UIFont.Weight,
                   size: PointSize) {
    let traits: [UIFontDescriptor.TraitKey: Any] = [.weight: weight]
    let attributes: [UIFontDescriptor.AttributeName: Any] = [.family: familyName,
                                                             .size: size.value,
                                                             .traits: traits]
    
    let descriptor = Font.bestDescriptor(matchingAttributes: attributes, weight: weight)
    self.init(descriptor: descriptor, size: size.value)
  }
  
  func weight(_ weight: UIFont.Weight) -> UIFont {
    var attributes = currentAttributes
    if var traits = attributes[.traits] as? [UIFontDescriptor.TraitKey: Any] {
      traits[.weight] = weight
      attributes[.traits] = traits
    }
    let descriptor = Font.bestDescriptor(matchingAttributes: attributes,
                                         weight: weight)
    return UIFont(descriptor: descriptor, size: pointSize)
  }
  
  func sized(_ size: PointSize) -> UIFont {
    return withSize(size.value)
  }
  
  private var currentAttributes: [UIFontDescriptor.AttributeName: Any] {
    var attributes = fontDescriptor.fontAttributes
    let traits = (fontDescriptor.object(forKey: .traits) ?? attributes[.traits]) as? [UIFontDescriptor.TraitKey: Any] ?? [:]
    attributes[.traits] = traits
    if attributes[.family] == nil { attributes[.family] = familyName }
    attributes[.name] = nil
    return attributes
  }
  
  // MARK: Weight Functions
  
  var ultraLight: UIFont { return weight(.ultraLight) }
  var extraLight: UIFont { return weight(.extraLight) }
  var thin: UIFont { return weight(.thin) }
  var book: UIFont { return weight(.book) }
  var demi: UIFont { return weight(.demi) }
  var normal: UIFont { return weight(.normal) }
  var light: UIFont { return weight(.light) }
  var regular: UIFont { return weight(.regular) }
  var medium: UIFont { return weight(.medium) }
  var demibold: UIFont { return weight(.demibold) }
  var semibold: UIFont { return weight(.semibold) }
  var bold: UIFont { return weight(.bold) }
  var extraBold: UIFont { return weight(.extraBold) }
  var heavy: UIFont { return weight(.heavy) }
  var black: UIFont { return weight(.black) }
  var extraBlack: UIFont { return weight(.extraBlack) }
  var ultraBlack: UIFont { return weight(.ultraBlack) }
  var fat: UIFont { return weight(.fat) }
  var poster: UIFont { return weight(.poster) }
  
  // MARK: Size Functions
  var tiny: UIFont { return sized(.tiny) }
  var small: UIFont { return sized(.small) }
  var normalSize: UIFont { return sized(.normal) }
  var mediumSize: UIFont { return sized(.medium) }
  var big: UIFont { return sized(.big) }
  var huge: UIFont { return sized(.huge) }
  var enormous: UIFont { return sized(.enormous) }
  func fixed(_ points: CGFloat) -> UIFont { return sized(.fixed(points: points)) }
  func specific(values: SizeSpecification) -> UIFont { return sized(.specific(with: values)) }
  func proportional(to base: BaseSize) -> UIFont { return sized(.proportional(to: base)) }
}

public extension UIFont.Weight {
  private static let equatableDiff: CGFloat = 0.0001
  static let extraLight = UIFont.Weight(rawValue: UIFont.Weight.ultraLight.rawValue + equatableDiff)
  static let book = UIFont.Weight(rawValue: -0.5)
  static let demi = UIFont.Weight(rawValue: -0.5 + equatableDiff)
  static let normal = UIFont.Weight(rawValue: 0 + equatableDiff)
  static let demibold = UIFont.Weight(rawValue: UIFont.Weight.semibold.rawValue + equatableDiff)
  static let extraBold = UIFont.Weight(rawValue: UIFont.Weight.black.rawValue + equatableDiff)
  static let extraBlack = UIFont.Weight(rawValue: 0.8)
  static let ultraBlack = UIFont.Weight(rawValue: UIFont.Weight.extraBlack.rawValue + equatableDiff)
  static let fat = UIFont.Weight(rawValue: UIFont.Weight.ultraBlack.rawValue + equatableDiff)
  static let poster = UIFont.Weight(rawValue: UIFont.Weight.fat.rawValue + equatableDiff)
  
  var faceName: String {
    switch self {
    case .ultraLight: return "UltraLight"
    case .extraLight: return "ExtraLight"
    case .thin: return "Thin"
    case .book: return "Book"
    case .demi: return "Demi"
    case .normal: return "Normal"
    case .light: return "Light"
    case .medium: return "Medium"
    case .demibold: return "DemiBold"
    case .semibold: return "SemiBold"
    case .bold: return "Bold"
    case .extraBold: return "ExtraBold"
    case .heavy: return "Heavy"
    case .black: return "Black"
    case .extraBlack: return "ExtraBlack"
    case .ultraBlack: return "UltraBlack"
    case .fat: return "Fat"
    case .poster: return "Poster"
    default: return "Regular"
    }
  }
}

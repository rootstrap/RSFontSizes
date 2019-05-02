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
  
  public var ultraLight: UIFont { return weight(.ultraLight) }
  public var extraLight: UIFont { return weight(.extraLight) }
  public var thin: UIFont { return weight(.thin) }
  public var book: UIFont { return weight(.book) }
  public var demi: UIFont { return weight(.demi) }
  public var normal: UIFont { return weight(.normal) }
  public var light: UIFont { return weight(.light) }
  public var regular: UIFont { return weight(.regular) }
  public var medium: UIFont { return weight(.medium) }
  public var demibold: UIFont { return weight(.demibold) }
  public var semibold: UIFont { return weight(.semibold) }
  public var bold: UIFont { return weight(.bold) }
  public var extraBold: UIFont { return weight(.extraBold) }
  public var heavy: UIFont { return weight(.heavy) }
  public var black: UIFont { return weight(.black) }
  public var extraBlack: UIFont { return weight(.extraBlack) }
  public var ultraBlack: UIFont { return weight(.ultraBlack) }
  public var fat: UIFont { return weight(.fat) }
  public var poster: UIFont { return weight(.poster) }
  
  // MARK: Size Functions
  public var tiny: UIFont { return sized(.tiny) }
  public var small: UIFont { return sized(.small) }
  public var normalSize: UIFont { return sized(.normal) }
  public var mediumSize: UIFont { return sized(.medium) }
  public var big: UIFont { return sized(.big) }
  public var huge: UIFont { return sized(.huge) }
  public var enormous: UIFont { return sized(.enormous) }
  public func fixed(_ points: CGFloat) -> UIFont { return sized(.fixed(points: points)) }
  public func specific(values: SizeSpecification) -> UIFont { return sized(.specific(with: values)) }
  public func proportional(to base: BaseSize) -> UIFont { return sized(.proportional(to: base)) }
}

public extension UIFont.Weight {
  private static let equatableDiff: CGFloat = 0.0001
  public static let extraLight = UIFont.Weight(rawValue: UIFont.Weight.ultraLight.rawValue + equatableDiff)
  public static let book = UIFont.Weight(rawValue: -0.5)
  public static let demi = UIFont.Weight(rawValue: -0.5 + equatableDiff)
  public static let normal = UIFont.Weight(rawValue: 0 + equatableDiff)
  public static let demibold = UIFont.Weight(rawValue: UIFont.Weight.semibold.rawValue + equatableDiff)
  public static let extraBold = UIFont.Weight(rawValue: UIFont.Weight.black.rawValue + equatableDiff)
  public static let extraBlack = UIFont.Weight(rawValue: 0.8)
  public static let ultraBlack = UIFont.Weight(rawValue: UIFont.Weight.extraBlack.rawValue + equatableDiff)
  public static let fat = UIFont.Weight(rawValue: UIFont.Weight.ultraBlack.rawValue + equatableDiff)
  public static let poster = UIFont.Weight(rawValue: UIFont.Weight.fat.rawValue + equatableDiff)
  
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

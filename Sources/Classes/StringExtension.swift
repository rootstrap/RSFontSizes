//
//  StringExtension.swift
//  RSFontSizes
//
//  Created by Rootstrap on 3/28/19.
//

import Foundation
import UIKit

@available(iOS 8.2, *)
extension String {
  public func font(withWeight weight: UIFont.Weight = .regular,
                   size: PointSize = .normal) -> UIFont? {
    guard !isEmpty else { return nil }
    return UIFont(familyName: self, weight: weight, size: size)
  }
}

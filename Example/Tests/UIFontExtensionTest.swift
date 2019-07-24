//
//  UIFontExtensionTest.swift
//  RSFontSizes_Tests
//
//  Created by German on 3/29/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation


import Quick
import Nimble
import RSFontSizes

class FontWeightsSpecs: QuickSpec {
  
  let testFont = "Raleway".font()!
  
  override func spec() {
    describe("UIFont.Weight extension") {
      context("faceName enum method") {
        it("returns the correct name for every style") {
          expect(UIFont.Weight.ultraLight.faceName) == "UltraLight"
          expect(UIFont.Weight.extraLight.faceName) == "ExtraLight"
          expect(UIFont.Weight.thin.faceName) == "Thin"
          expect(UIFont.Weight.book.faceName) == "Book"
          expect(UIFont.Weight.demi.faceName) == "Demi"
          expect(UIFont.Weight.normal.faceName) == "Normal"
          expect(UIFont.Weight.light.faceName) == "Light"
          expect(UIFont.Weight.medium.faceName) == "Medium"
          expect(UIFont.Weight.demibold.faceName) == "DemiBold"
          expect(UIFont.Weight.semibold.faceName) == "SemiBold"
          expect(UIFont.Weight.bold.faceName) == "Bold"
          expect(UIFont.Weight.extraBold.faceName) == "ExtraBold"
          expect(UIFont.Weight.heavy.faceName) == "Heavy"
          expect(UIFont.Weight.black.faceName) == "Black"
          expect(UIFont.Weight.extraBlack.faceName) == "ExtraBlack"
          expect(UIFont.Weight.ultraBlack.faceName) == "UltraBlack"
          expect(UIFont.Weight.fat.faceName) == "Fat"
          expect(UIFont.Weight.poster.faceName) == "Poster"
          expect(UIFont.Weight.ultraLight.faceName) == "UltraLight"
          expect(UIFont.Weight.regular.faceName) == "Regular"
        }
      }
      
      context("Font weight modifiers") {
        it("Does not change the font size") {
          let initialSize = self.testFont.pointSize
          let font = self.testFont.bold
          expect(font.pointSize) == initialSize
        }
      }
      
      context("Font Size modifiers") {
        it("Does not change the font weight") {
          let initialName = self.testFont.fontName
          let resizedFont = self.testFont.huge
          expect(resizedFont.fontName) == initialName
        }
      }
    }
  }
}

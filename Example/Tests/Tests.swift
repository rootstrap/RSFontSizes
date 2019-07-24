
import Quick
import Nimble
import RSFontSizes
import Device

class TableOfContentsSpec: QuickSpec {
  
  let testFont = "Raleway".font()!
  
  override func spec() {
  
    describe("RSFontSizes") {
      
      context("Font generation tests") {
        it("can find the correct font assets") {
          var font = self.testFont.bold.tiny
          var desired = UIFont(name: "Raleway-Bold", size: 8)
          expect(font) == desired
          font = self.testFont.regular.small
          desired = UIFont(name: "Raleway-Regular", size: 12)
          expect(font) == desired
          font = self.testFont.black.normalSize
          desired = UIFont(name: "Raleway-Black", size: 16)
          expect(font) == desired
          font = self.testFont.semibold.mediumSize
          desired = UIFont(name: "Raleway-SemiBold", size: 20)
          expect(font) == desired
        }
        
        it("can find similar font assets") {
          //Heavy variant is not linked and Black is similar.
          let font = self.testFont.heavy.small
          let alternative = UIFont(name: "Raleway-Black", size: 12)
          expect(font) == alternative
        }
        
        it("returns a default font for an incorrect family") {
          let font = "Ralewy".font(withWeight: .regular, size: .small)
          expect(font?.familyName) != self.testFont.familyName
        }
      }
      
      context("Font sizing tests") {
        
        it("uses the correct point size for predefined classes") {
          var font = self.testFont.tiny
          expect(font.pointSize) == 8
          font = self.testFont.small
          expect(font.pointSize) == 12
          font = self.testFont.normalSize
          expect(font.pointSize) == 16
          font = self.testFont.mediumSize
          expect(font.pointSize) == 20
          font = self.testFont.big
          expect(font.pointSize) == 24
          font = self.testFont.huge
          expect(font.pointSize) == 32
          font = self.testFont.enormous
          expect(font.pointSize) == 40
        }
        
        it("returns the correct fixed size") {
          let randomSize = CGFloat(arc4random_uniform(60))
          let font = self.testFont.fixed(randomSize)
          expect(font.pointSize) == randomSize
        }
        
        it("calculates proportional sizes correctly") {
          let allSizes = Size.all
          var font: UIFont?
          var base: BaseSize
          for size in allSizes {
            base = (size, 12)
            font = self.testFont.proportional(to: base)
            let desired = base.1 * Device.size().inches / base.0.inches
            expect(font?.pointSize).to(beCloseTo(desired, within: 0.00001))
          }
        }
        
        context("User specifics behaviour") {
          it("uses the correct size from user specifics") {
            let specifics: SizeSpecification =  [Device.size(): 22]
            let font = self.testFont.specific(values: specifics)
            expect(font.pointSize) == 22
          }
          
          it("returns the closest size when current device specification is missing") {
            let font = self.testFont.specific(values:  [Device.size().closer: 14])
            expect(font.pointSize) == 14
          }
          
          it("returns a smart estimation based on the smaller screen size for empty specifics") {
            let font = self.testFont.specific(values: [:])
            let expectation = 12 * Device.size().inches / Size.screen3_5Inch.inches
            expect(font.pointSize).to(beCloseTo(expectation, within: 0.00001))
          }
          
          //No specifics found for the current device nor for the closer size.
          it("uses a point size proportional to the first specific") {
            var farSize = Device.size()
            for size in Size.all {
              if size != farSize && size != farSize.closer {
                farSize = size
                break
              }
            }
            let specifics: SizeSpecification = [farSize: 18]
            let font = self.testFont.specific(values: specifics)
            let expectation = specifics[farSize]! * Device.size().inches / farSize.inches
            expect(font.pointSize).to(beCloseTo(expectation, within: 0.00001))
          }
        }
      }
      
      context("Font preferences tests") {
        it("correctly saves and returns a font asociated to a class") {
          let font = self.testFont.regular.mediumSize
          Font.save(font: font, forClass: .headline)
          let saved = Font.with(class: .headline)
          expect(saved).notTo(beNil())
          expect(saved) == font
        }
      }
    }
  }
}

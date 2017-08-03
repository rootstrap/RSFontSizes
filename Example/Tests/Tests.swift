
import Quick
import Nimble
import RSFontSizes
import Device

class TableOfContentsSpec: QuickSpec {
  
  let testFont = "Raleway"
  
  override func spec() {
  
    describe("RSFontSizes") {
      
      context("Font generation tests") { 
        it("can find the correct font assets") {
          var font = self.testFont.with(style: .bold, size: .tiny)
          var desired = UIFont(name: "Raleway-Bold", size: 8)
          expect(font) == desired
          font = self.testFont.with(style: .regular, size: .small)
          desired = UIFont(name: "Raleway-Regular", size: 12)
          expect(font) == desired
          font = self.testFont.with(style: .black, size: .normal)
          desired = UIFont(name: "Raleway-Black", size: 16)
          expect(font) == desired
          font = self.testFont.with(style: .semibold, size: .medium)
          desired = UIFont(name: "Raleway-SemiBold", size: 20)
          expect(font) == desired
        }
        
        it("can find similar font assets") {
          var font = self.testFont.with(style: .light, size: .small)
          var alternative = UIFont(name: "Raleway-Thin", size: 12)
          expect(font) == alternative
          //ExtraBold variant is not linked and Black is similar.
          font = self.testFont.with(style: .extraBold, size: .small)
          alternative = UIFont(name: "Raleway-Black", size: 12)
          expect(font) == alternative
          //Italic variant is not linked and does not have similarities.
          font = self.testFont.with(style: .italic, size: .small)
          expect(font) == UIFont(name: "Raleway", size: 12)
        }
        
        it("returns a default font for an incorrect family") {
          let font = "Ralewy".with(style: .regular, size: .small)
          let system = UIFont.systemFont(ofSize: 12)
          expect(font) == system
        }
      }
      
      context("Font sizing tests") {
        
        it("uses the correct point size for predefined classes") {
          var font = self.testFont.with(style: .regular, size: .tiny)
          expect(font?.pointSize) == 8
          font = self.testFont.with(style: .regular, size: .small)
          expect(font?.pointSize) == 12
          font = self.testFont.with(style: .regular, size: .normal)
          expect(font?.pointSize) == 16
          font = self.testFont.with(style: .regular, size: .medium)
          expect(font?.pointSize) == 20
          font = self.testFont.with(style: .regular, size: .big)
          expect(font?.pointSize) == 24
          font = self.testFont.with(style: .regular, size: .huge)
          expect(font?.pointSize) == 32
          font = self.testFont.with(style: .regular, size: .enormous)
          expect(font?.pointSize) == 40
        }
        
        it("returns the correct fixed size") {
          let randomSize = CGFloat(arc4random_uniform(60))
          let font = self.testFont.with(style: .bold, size: .fixed(randomSize))
          expect(font?.pointSize) == randomSize
        }
        
        it("calculates proportional sizes correctly") {
          let allSizes = Size.all
          var font: UIFont?
          var base: BaseSize
          for size in allSizes {
            base = (size, 12)
            font = self.testFont.with(style: .regular, size: .proportional(to: base))
            let desired = base.1 * Device.size().inches()/base.0.inches()
            expect(font?.pointSize).to(beCloseTo(desired, within: 0.00001))
          }
        }
        
        context("User specifics behaviour") {
          it("uses the correct size from user specifics") {
            let specifics: SizeSpecification =  [Device.size(): 22]
            let font = self.testFont.with(style: .bold, size: .specific(with: specifics))
            expect(font?.pointSize) == 22
          }
          
          it("returns the closest size when current device specification is missing") {
            let font = self.testFont.with(style: .medium, size: .specific(with:  [Device.size().closer(): 14]))
            expect(font?.pointSize) == 14
          }
          
          it("returns a smart estimation based on the smaller screen size for empty specifics") {
            let font = self.testFont.with(style: .medium, size: .specific(with: [:]))
            let expectation = 12 * Device.size().inches()/Size.screen3_5Inch.inches()
            expect(font?.pointSize).to(beCloseTo(expectation, within: 0.00001))
          }
          
          //No specifics found for the current device nor for the closer size.
          it("uses a point size proportional to the first specific") {
            var farSize = Device.size()
            for size in Size.all {
              if size != farSize && size != farSize.closer() {
                farSize = size
                break
              }
            }
            let specifics: SizeSpecification = [farSize: 18]
            let font = self.testFont.with(style: .medium, size: .specific(with: specifics))
            let expectation = specifics[farSize]! * Device.size().inches()/farSize.inches()
            expect(font?.pointSize).to(beCloseTo(expectation, within: 0.00001))
          }
        }
      }
      
      context("Font preferences tests") {
        it("correctly saves and returns a font asociated to a class") {
          let font = self.testFont.with(style: .regular, size: .medium)
          Font.save(font: font, forClass: .headline)
          let saved = Font.with(class: .headline)
          expect(saved) != nil
          expect(saved) == font
        }
      }
    }
  }
}

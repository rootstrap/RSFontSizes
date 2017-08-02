# RSFontSizes

[![CI Status](http://img.shields.io/travis/rootstrap/RSFontSizes.svg?style=flat)](https://travis-ci.org/rootstrap/RSFontSizes)
[![Version](https://img.shields.io/cocoapods/v/RSFontSizes.svg?style=flat)](http://cocoapods.org/pods/RSFontSizes)
[![License](https://img.shields.io/cocoapods/l/RSFontSizes.svg?style=flat)](http://cocoapods.org/pods/RSFontSizes)
[![Platform](https://img.shields.io/cocoapods/p/RSFontSizes.svg?style=flat)](http://cocoapods.org/pods/RSFontSizes)

## What is it?

RSFontSize allows you to manage different font sizes for every device screen size in a flexible manner.
- No more family name and styles typing/guessing every time you use a font.
- Flexible size configurations(Fixed, Proportional to screen size and user specific).
- Smart size estimation for vague specifications.
- Save your font configurations for different UIFontTextStyle(.body, .title, etc).

### Quick peak

From poorly managed font sizes:

![Normal Preview](https://github.com/rootstrap/RSFontSizes/blob/master/fixed-font-sizes.jpg?raw=true)

Fonts are set directly from IB.

To readable texts:

![Preview With RSFontSizes](https://github.com/rootstrap/RSFontSizes/blob/master/dynamic-font-sizes.jpg?raw=true)

Fonts using RSFontSizes.


## Start using RSFontSizes

Just link your font assets to the project. Very detailed guide [here](http://codewithchris.com/common-mistakes-with-adding-custom-fonts-to-your-ios-app/).

If there are too many font files to add, I recommend FontBlaster pod.
It's a simple solution to load your assets automatically instead of manually adding every file to the Info.plist.

### Optionally add your favourite fonts.

```swift
extension Font {
  //Your Custom font family names
  static let raleway = "Raleway"
}
```

## Perks

There are different types to get your fonts correctly sized:

-Fixed: The consumer sets the font point size or uses one of the provided classes(.small, .medium, etc). 

```swift
let font = Font.raleway.with(style: .regular, size: .medium)
```

No magic here :)

-Proportional: The consumer will specify a base font size asociated with a device screen size. 

```swift
let font = Font.raleway.with(style: .thin, size: .proportional(to: (.screen3_5Inch, 10)))
```

The result will be a font resized accordingly for the current device screen size.  

-Screen Specific: The consumer defines a set of font sizes linked to an specific screen size. 

```swift
let font = Font.raleway.with(style: .regular, 
                             size: .specific(with: [.screen4Inch:12, 
                                                    .screen4_7Inch: 13.5,
                                                    .screen5_5Inch: 16,
                                                    .screen9_7Inch: 20.2]))
```

If a screen size is not specified the library will try to estimate the correct value for the font size.

### You can also...

#### Use a String as the Font family name

```swift
let font = "Raleway".with(style: .bold, size: .fixed(20))
```

#### Save your 'templates' to reuse

```swift
Font.save(font: someFont, forClass: .title)
```

And then use it elsewhere:

```swift
let label.font = Font.with(class: .body)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RSFontSizes is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RSFontSizes"
```

## Author

Rootstrap Inc., german@rootstrap.com

## License

RSFontSizes is available under the MIT license. See the LICENSE file for more info.

# RSFontSizes

[![CI Status](http://img.shields.io/travis/jpmazza/RSFontSizes.svg?style=flat)](https://travis-ci.org/toptier/FontSizes)
[![Version](https://img.shields.io/cocoapods/v/RSFontSizes.svg?style=flat)](http://cocoapods.org/pods/FontSizes)
[![License](https://img.shields.io/cocoapods/l/RSFontSizes.svg?style=flat)](http://cocoapods.org/pods/FontSizes)
[![Platform](https://img.shields.io/cocoapods/p/RSFontSizes.svg?style=flat)](http://cocoapods.org/pods/FontSizes)

## What is it?

RSFontSize allows you to manage different font sizes for every device screen size in a flexible manner.
- No more family name and styles typing/guessing every time you use a font.
- Flexible size configurations(Fixed, Proportional to screen size and user specific).
- Smart size estimation for vague specifications.
- Save your font configurations for different UIFontTextStyle(.body, .title, etc).

### Quick peak

From nearly invisible texts:

![Normal Preview](https://github.com/rootstrap/RSFontSizes/blob/master/fixed-font-sizes.jpg?raw=true)

To adjustable font sizes:

![Preview With RSFontSizes](https://github.com/rootstrap/RSFontSizes/blob/master/dynamic-font-sizes.jpg?raw=true)

With a simple line of code:

```swift
Font.raleway.withStyle(.regular, size: .specific(with: [.screen4Inch: 12, .screen4_7Inch: 13.5,
.screen5_5Inch: 16,
.screen9_7Inch: 20.2]))```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FontSizes is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RSFontSizes"
```

## Author

Rootstrap Inc., german@rootstrap.com

## License

RSFontSizes is available under the MIT license. See the LICENSE file for more info.

//The MIT License (MIT)
//
//Copyright (c) 2015 Lucas Ortis
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation
import UIKit

open class Device {
  static fileprivate func getVersionCode() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
    
    return versionCode
  }
  
  static fileprivate func getVersion(code: String) -> Version {
    switch code {
      /*** iPhone ***/
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return .iPhone4
    case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return .iPhone4S
    case "iPhone5,1", "iPhone5,2":                   return .iPhone5
    case "iPhone5,3", "iPhone5,4":                   return .iPhone5C
    case "iPhone6,1", "iPhone6,2":                   return .iPhone5S
    case "iPhone7,2":                                return .iPhone6
    case "iPhone7,1":                                return .iPhone6Plus
    case "iPhone8,1":                                return .iPhone6S
    case "iPhone8,2":                                return .iPhone6SPlus
    case "iPhone8,4":                                return .iPhoneSE
    case "iPhone9,1", "iPhone9,3":                   return .iPhone7
    case "iPhone9,2", "iPhone9,4":                   return .iPhone7Plus
      
      /*** iPad ***/
    case "iPad1,1":                                  return Version.iPad1
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return Version.iPad2
    case "iPad3,1", "iPad3,2", "iPad3,3":            return Version.iPad3
    case "iPad3,4", "iPad3,5", "iPad3,6":            return Version.iPad4
    case "iPad6,11", "iPad6,12":                     return Version.iPad5
    case "iPad4,1", "iPad4,2", "iPad4,3":            return Version.iPadAir
    case "iPad5,3", "iPad5,4":                       return Version.iPadAir2
    case "iPad2,5", "iPad2,6", "iPad2,7":            return Version.iPadMini
    case "iPad4,4", "iPad4,5", "iPad4,6":            return Version.iPadMini2
    case "iPad4,7", "iPad4,8", "iPad4,9":            return Version.iPadMini3
    case "iPad5,1", "iPad5,2":                       return Version.iPadMini4
    case "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2": return Version.iPadPro12_9Inch
    case "iPad7,3", "iPad7,4":                       return Version.iPadPro10_5Inch
    case "iPad6,3", "iPad6,4":                       return Version.iPadPro9_7Inch
      
      /*** iPod ***/
    case "iPod1,1":                                  return .iPodTouch1Gen
    case "iPod2,1":                                  return .iPodTouch2Gen
    case "iPod3,1":                                  return .iPodTouch3Gen
    case "iPod4,1":                                  return .iPodTouch4Gen
    case "iPod5,1":                                  return .iPodTouch5Gen
    case "iPod7,1":                                  return .iPodTouch6Gen
      
      /*** Simulator ***/
    case "i386", "x86_64":                           return .simulator
      
    default:                                         return .unknown
    }
  }
  
  static open func version() -> Version {
    return getVersion(code: getVersionCode())
  }
  
  static open func size() -> Size {
    let w: Double = Double(UIScreen.main.bounds.width)
    let h: Double = Double(UIScreen.main.bounds.height)
    let screenHeight: Double = max(w, h)
    
    switch screenHeight {
    case 480:
      return .screen3_5Inch
    case 568:
      return .screen4Inch
    case 667:
      return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
    case 736:
      return .screen5_5Inch
    case 1024:
      switch version() {
      case .iPadMini,.iPadMini2,.iPadMini3,.iPadMini4:
        return .screen7_9Inch
      case .iPadPro10_5Inch:
        return .screen10_5Inch
      default:
        return .screen9_7Inch
      }
    case 1112:
      return .screen10_5Inch
    case 1366:
      return .screen12_9Inch
    default:
      return .unknownSize
    }
  }
  
  static open func isRetina() -> Bool {
    return UIScreen.main.scale > 1.0
  }
}

public enum Size: CGFloat, Comparable {
  case unknownSize = 0
  #if os(iOS)
  case screen3_5Inch = 3.5
  case screen4Inch = 4
  case screen4_7Inch = 4.7
  case screen5_5Inch = 5.5
  case screen7_9Inch = 7.9
  case screen9_7Inch = 9.7
  case screen10_5Inch = 10.5
  case screen12_9Inch = 12.9
  #elseif os(OSX)
  case screen11Inch = 11
  case screen12Inch = 12
  case screen13Inch = 13
  case screen15Inch = 15
  case screen17Inch = 17
  case screen20Inch = 20
  case screen21_5Inch = 21.5
  case screen24Inch = 24
  case screen27Inch = 27
  #endif
}

public func <(lhs: Size, rhs: Size) -> Bool {
  return lhs.rawValue < rhs.rawValue
}

public func ==(lhs: Size, rhs: Size) -> Bool {
  return lhs.rawValue == rhs.rawValue
}

public enum Version: String {
  /*** iPhone ***/
  case iPhone4
  case iPhone4S
  case iPhone5
  case iPhone5C
  case iPhone5S
  case iPhone6
  case iPhone6Plus
  case iPhone6S
  case iPhone6SPlus
  case iPhoneSE
  case iPhone7
  case iPhone7Plus
  
  /*** iPad ***/
  case iPad1
  case iPad2
  case iPad3
  case iPad4
  case iPad5
  case iPadAir
  case iPadAir2
  case iPadMini
  case iPadMini2
  case iPadMini3
  case iPadMini4
  case iPadPro9_7Inch
  case iPadPro10_5Inch
  case iPadPro12_9Inch
  
  /*** iPod ***/
  case iPodTouch1Gen
  case iPodTouch2Gen
  case iPodTouch3Gen
  case iPodTouch4Gen
  case iPodTouch5Gen
  case iPodTouch6Gen
  
  /*** simulator ***/
  case simulator
  
  /*** unknown ***/
  case unknown
}

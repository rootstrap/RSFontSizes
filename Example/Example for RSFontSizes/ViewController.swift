//
//  ViewController.swift
//  FontSizes
//
//  Created by German on 07/31/2017.
//  Copyright (c) 2017 German Lopez. All rights reserved.
//

import UIKit
import RSFontSizes
import Device

class ViewController: UIViewController {
  
  @IBOutlet weak var model: UILabel!
  @IBOutlet weak var previewFixed: UILabel!
  @IBOutlet weak var previewSpecifics: UILabel!
  @IBOutlet weak var previewProportional: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    model.text = String(format: "Screen size: %.1f\"", Device.size().inches)
    
    // Customize any UIFont object
    previewFixed.font = Font.raleway.mediumSize.bold
    previewProportional.font = Font.raleway.thin.proportional(to: (.screen3_5Inch, 10))
    // Create fonts from a String indicating the family name
    let font = "Raleway".font(withWeight: .regular,
                              size: .specific(with: [.screen4Inch: 12,
                                                     .screen4_7Inch:13.5,
                                                     .screen5_5Inch: 16,
                                                     .screen9_7Inch: 20.2]))
    
    // Save UIFont preferences for different UIFont.TextStyle(.body, .headline, .etc)
    Font.save(font: font, forClass: .body)
    previewSpecifics.font = Font.with(class: .body)
  }
}

extension Font {
  //Custom font families
  static let raleway = "Raleway".font()!
}


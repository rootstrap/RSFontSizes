//
//  ViewController.swift
//  FontSizes
//
//  Created by German on 07/31/2017.
//  Copyright (c) 2017 German Lopez. All rights reserved.
//

import UIKit
import RSFontSizes

class ViewController: UIViewController {
  
  @IBOutlet weak var model: UILabel!
  @IBOutlet weak var previewFixed: UILabel!
  @IBOutlet weak var previewSpecifics: UILabel!
  @IBOutlet weak var previewProportional: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model.text = String(format: "Screen size: %.1f\"", Device.size().rawValue)
    
    previewFixed.font = Font.raleway.with(style: .bold, size: .fixed(20))
    previewProportional.font = Font.raleway.with(style: .thin, size: .proportional(to: (.screen3_5Inch, 10)))
    let font = "Raleway".with(style: .regular,
                              size: .specific(with: [.screen4Inch: 12,
                                                     .screen4_7Inch:13.5,
                                                     .screen5_5Inch: 16,
                                                     .screen9_7Inch: 20.2]))
    Font.save(font: font, forClass: .body)
    previewSpecifics.font = Font.with(class: .body)
  }
}

extension Font {
  //Custom font families
  static let raleway = "Raleway"
}


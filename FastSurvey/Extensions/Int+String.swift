//
//  Int+String.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation

extension Int {
     var string: String {
         get { String(self) }
         set { self = Int(newValue) ?? .max }
     }
 }

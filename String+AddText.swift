//
//  String+AddText.swift
//  MyLocations
//
//  Created by Jack Burton on 8/7/16.
//  Copyright © 2016 Pork Chop Express. All rights reserved.////

extension String {
    mutating func addText(text: String?, withSeparator separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}



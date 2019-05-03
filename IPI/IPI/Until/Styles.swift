//
//  Styles.swift
//  IPI
//
//  Created by Felipe Zamudio on 3/05/19.
//  Copyright © 2019 NRC. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extensions

//add "Underline" to textFiel
extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

// MARK: - Funtions
/// change to *Bold* the word(s) into a text
func addBoldWord(forText text: String, toWord words: String..., fontSize size: CGFloat) -> NSAttributedString {

    let attributeText = NSMutableAttributedString(string: text)
    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size)]
//    let italicFontAttribute = [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: size)]

    for word in words {
        let range = (text as NSString).range(of: word)
        attributeText.addAttributes(boldFontAttribute, range: range)
    }

    return attributeText
}
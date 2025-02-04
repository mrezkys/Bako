//
//  Text+Extensions.swift
//  Bako
//
//  Created by Muhammad Rezky on 19/11/24.
//

import SwiftUI

enum FontWeight {
    case extraLight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case extraBold
}

enum FontStyle {
    case normal
    case italic
}

extension Font {
    static let customFont: (FontWeight, FontStyle, CGFloat) -> Font = { fontWeight, fontStyle, size in
        let fontName: String
        
        switch (fontWeight, fontStyle) {
        case (.extraLight, .normal):
            fontName = "PlusJakartaSans-ExtraLight"
        case (.extraLight, .italic):
            fontName = "PlusJakartaSans-ExtraLightItalic"
        case (.light, .normal):
            fontName = "PlusJakartaSans-Light"
        case (.light, .italic):
            fontName = "PlusJakartaSans-LightItalic"
        case (.regular, .normal):
            fontName = "PlusJakartaSans-Regular"
        case (.regular, .italic):
            fontName = "PlusJakartaSans-Italic"
        case (.medium, .normal):
            fontName = "PlusJakartaSans-Medium"
        case (.medium, .italic):
            fontName = "PlusJakartaSans-MediumItalic"
        case (.semiBold, .normal):
            fontName = "PlusJakartaSans-SemiBold"
        case (.semiBold, .italic):
            fontName = "PlusJakartaSans-SemiBoldItalic"
        case (.bold, .normal):
            fontName = "PlusJakartaSans-Bold"
        case (.bold, .italic):
            fontName = "PlusJakartaSans-BoldItalic"
        case (.extraBold, .normal):
            fontName = "PlusJakartaSans-ExtraBold"
        case (.extraBold, .italic):
            fontName = "PlusJakartaSans-ExtraBoldItalic"
        }
        
        return Font.custom(fontName, size: size)
    }
}

extension Text {
    func plusJakartaFont(_ fontWeight: FontWeight? = .regular, _ fontStyle: FontStyle? = .normal, _ size: CGFloat? = nil) -> Text {
        self.font(.customFont(fontWeight ?? .regular, fontStyle ?? .normal, size ?? 16))
    }
    
    
    func plusJakartaFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        self.font(.customFont(fontWeight ?? .regular, .normal, size ?? 16))
    }
}

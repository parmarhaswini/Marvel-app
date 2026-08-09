//
//  FontsConst.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 17/05/26.
//

import Foundation
import SwiftUI

/// Constant for adding fonts
///
struct FontsConst {
    
    static func regular(_ size: CGFloat) -> Font {
           .custom("Inter18pt-Regular", size: size)
       }
    
    static func italic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-Italic", size: size)
    }
    
    static func bold(_ size: CGFloat) -> Font {
        .custom("Inter18pt-Bold", size: size)
    }
    
    static func boldItalic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-BoldItalic", size: size)
    }
    
    static func extraBold(_ size: CGFloat) -> Font {
        .custom("Inter18pt-ExtraBold", size: size)
    }
    
    static func extraBoldItalic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-ExtraBoldItalic", size: size)
    }
    
    static func extraLight(_ size: CGFloat) -> Font {
        .custom("Inter18pt-ExtraLight", size: size)
    }
    
    static func extraLightItalic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-ExtraLightItalic", size: size)
    }
    
    static func thin(_ size: CGFloat) -> Font {
        .custom("Inter18pt-Thin", size: size)
    }
    
    static func italicThin(_ size: CGFloat) -> Font {
        .custom("Inter18pt-ThinItalic", size: size)
    }
    
    static func lightItalice(_ size: CGFloat) -> Font {
        .custom("Inter18pt-LightItalic", size: size)
    }
    
    static func light(_ size: CGFloat) -> Font {
        .custom("Inter18pt-Light", size: size)
    }
    
    static func semiBold(_ size: CGFloat) -> Font {
        .custom("Inter18pt-SemiBold", size: size)
    }
    
    static func semiBoldItalic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-semiBoldItalic", size: size)
    }
    
    static func medium(_ size: CGFloat) -> Font {
        .custom("Inter18pt-Medium", size: size)
    }
    
    static func mediumItalic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-MediumItalic", size: size)
    }
    
    static func interBlack(_ size: CGFloat) -> Font {
        .custom("Inter18pt-Black", size: size)
    }
    
    static func interBlackItalic(_ size: CGFloat) -> Font {
        .custom("Inter18pt-BlackItalic", size: size)
    }
}



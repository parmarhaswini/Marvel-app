//
//  ImageConst.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 17/05/26.
//

import Foundation
import SwiftUI

enum ImageAsset: String {
	case launchscreenImage = "launchscreenImage"
	case welcomeScreenOne = "welcomeScreenOne"
	case welcomeScreenTwo = "welcomeScreenTwo"
	case welcomeScreenThree = "welcomeScreenThree"
	case welcomeScreenFour = "welcomeScreenFour"
	case welcomeScreenFive = "welcomeScreenFive"
	case welcomeScreenSix = "welcomeScreenSix"

	var view: Image {
		Image(self.rawValue)
	}
}

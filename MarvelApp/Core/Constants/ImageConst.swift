//
//  ImageConst.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 17/05/26.
//

import Foundation
import SwiftUI

enum ImageAsset: String {
	//launchscreen image
	case launchscreenImage = "launchscreenImage"
	// welcome screen image
	case welcomeScreenOne = "welcomeScreenOne"
	case welcomeScreenTwo = "welcomeScreenTwo"
	case welcomeScreenThree = "welcomeScreenThree"
	case welcomeScreenFour = "welcomeScreenFour"
	case welcomeScreenFive = "welcomeScreenFive"
	case welcomeScreenSix = "welcomeScreenSix"

	/// login and sign up image
	case facebook = "facebook"
	case google = "google"
	
	var view: Image {
		Image(self.rawValue)
	}
}

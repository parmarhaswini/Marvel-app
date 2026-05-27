//
//  WelcomScreenVM.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 25/05/26.
//

import Foundation
import Combine


class WelcomeScreenViewModel: ObservableObject {

	@Published var currentPage: Int = 0

	let pages = [
		WelcomeScreenItems(
			image: ImageAsset.welcomeScreenOne.view,
			title: TextsConst.allYourFavMoviesAndSeriesText, showContinueButton: true
		),
		WelcomeScreenItems(
			image: ImageAsset.welcomeScreenTwo.view,
			title: TextsConst.watchOnlineAndDownloadOfflineText, showContinueButton: true
		),
		WelcomeScreenItems(
			image: ImageAsset.welcomeScreenThree.view,
			title: TextsConst.createProfileText, showContinueButton: true
		),
		WelcomeScreenItems(
			image: ImageAsset.welcomeScreenFour.view,
			title: TextsConst.planAccordingText, showContinueButton: true
		),
		WelcomeScreenItems(
			image: ImageAsset.welcomeScreenFive.view,
			title: TextsConst.getStartedText, showContinueButton: true
		),
		WelcomeScreenItems(image: ImageAsset.welcomeScreenSix.view,
						   title: "", showContinueButton: false)
	]
}

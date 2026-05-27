//
//  ContentView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 19/04/26.
//

import SwiftUI

/**
 WelcomeScreenView
 
 A multi-page onboarding/welcome screen for the MarvelApp.
 
 **Purpose:**
 Presents an engaging introduction to the app with rich visuals and context-aware user options.
 
 **Features Included:**
 - Full-screen swipeable pages, each with a themed background image
 - Centered MarvelApp logo and animated page indicators
 - Dynamic title text for each page
 - Navigation through pages using horizontal swipe gestures
 - Context-sensitive action buttons:
     - "Continue" button for progressing through introductory pages
     - On the final page, "Sign Up" and "Login" buttons for account actions
 - Responsive layout: Logo and content remain centered regardless of the button area
 
 The view uses a @StateObject view model to control page state, page content, and button logic. Designed to act as the first screen shown to new or returning users.
*/
struct WelcomeScreenView: View {

	// observable viewmodel instance
	@StateObject private var viewModel: WelcomeScreenViewModel = WelcomeScreenViewModel()

	var body: some View {

		ZStack {
			// MARK: - Full Screen Swipe
			TabView(selection: $viewModel.currentPage) {

				ForEach(Array(viewModel.pages.enumerated()), id: \.offset) { offset, item in

					ZStack {
						// Background
						item.image
							.resizable()
							.scaledToFill()
							.ignoresSafeArea()
					}
					.tag(offset)
				}
			}
			.ignoresSafeArea()
			.tabViewStyle(.page(indexDisplayMode: .never))

			// MARK: - Foreground Content
			VStack {
				Spacer()
				// Centered Logo and controls
				VStack(spacing: Numbers.twenty) {
					// Logo
					ImageAsset.launchscreenImage.view
						.resizable()
						.scaledToFit()
						.frame(width: Numbers.oneEightyEight, height: Numbers.oneFourty)
					// Page Control
					HStack(spacing: Numbers.ten) {
						ForEach(0..<viewModel.pages.count, id: \.self) { index in
							Circle()
								.fill(
									index == viewModel.currentPage
									? Colors.redED1B24
									: Colors.whiteFFFFFF
								)
								.frame(width: Numbers.eight, height: Numbers.eight)
								.scaleEffect(
									index == viewModel.currentPage ? Numbers.onePointtwo : Numbers.one
								)
								.animation(
									.easeInOut(duration: Numbers.pointTwo),
									value: viewModel.currentPage
								)
						}
					}
					// Title
					Text(viewModel.pages[viewModel.currentPage].title)
						.font(
							FontsConst.semiBold(Numbers.twenty)
						)
						.multilineTextAlignment(.center)
						.foregroundColor(.white)
						.padding(.horizontal, Numbers.thirty)
						.frame(height: Numbers.hundred)
						.animation(.easeInOut, value: viewModel.currentPage)
				}
				Spacer()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)

			VStack {
				if(viewModel.pages[viewModel.currentPage].showContinueButton) {
					UIButtons(title: TextsConst.continueButtonText, style: .filled) {
						viewModel.currentPage = viewModel.currentPage.advanced(by: 1)
					}
					.padding(.horizontal, Numbers.twentyFour)
					.padding(.bottom, Numbers.eighty)
				} else {
					VStack(alignment: .center) {
						UIButtons(title: TextsConst.signUpText, style: .filled) {
							//navigate to sign up page
						}
						.padding(.horizontal, Numbers.twentyFour)
						.padding(.bottom, Numbers.thirty)
						UIButtons(title: TextsConst.loginText, style: .bordered) {
							//navigate to login page
						}
						.padding(.horizontal, Numbers.twentyFour)
						.padding(.bottom, Numbers.eighty)
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		}
	}
}

#Preview {
	WelcomeScreenView()
}

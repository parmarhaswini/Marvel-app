//
//  SignupView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 26/05/26.
//

import SwiftUI

struct AuthView: View {

	// MARK: - Properties

	let type: AuthType
	@Binding var selectedAuthType: AuthType?
	@State private var email = ""
	@State private var password = ""

	// MARK: - Body
	var body: some View {
		ScrollView {
			VStack(spacing: Numbers.sixteen) {

				// MARK: - Marvel Logo
				ImageAsset.launchscreenImage.view
					.resizable()
					.scaledToFit()
					.frame(
						width: Numbers.oneEightyEight,
						height: Numbers.oneFourty
					)
					.padding(.bottom, Numbers.fortyFour)

				// MARK: - Form
				FormView(
					fields: [
						FormFieldModel(
							placeholder: TextsConst.enterYourEmailIDText,
							isPasswordField: false,
							keyboardType: .emailAddress,
							text: $email
						),

						FormFieldModel(
							placeholder: TextsConst.passwordText,
							isPasswordField: true,
							keyboardType: .default,
							text: $password
						)
					]
				)

				// MARK: - Login / Signup Button

				UIButtons(
					title: type.buttonTitle,
					style: .bordered
				) {
					handleAction()
				}
				.padding(.top, Numbers.twentyFour)

				// MARK: - Forgot Password

				if type == .login {

					Button(TextsConst.forgotPasswordText) {
						// TODO: - Navigate to forgot password
					}
					.frame(maxWidth: .infinity, alignment: .trailing)
					.foregroundStyle(
						Colors.whiteFFFFFF.opacity(Numbers.pointSeven)
					)
					.font(FontsConst.extraBold(Numbers.fifteen))
				}

				// MARK: - OR

				Text(TextsConst.orText)
					.foregroundStyle(
						Colors.whiteFFFFFF.opacity(Numbers.pointFive)
					)
					.font(FontsConst.extraBold(Numbers.twenty))

				// MARK: - Continue With
				Text(TextsConst.continueWithText)
					.foregroundStyle(Colors.whiteFFFFFF)
					.font(FontsConst.extraBold(Numbers.twenty))
					.padding(.bottom, Numbers.twentyFour)

				// MARK: - Social Login
				HStack(spacing: Numbers.sixteen) {

					socialButton(
						image: ImageAsset.facebook.view,
						title: TextsConst.facebookText
					) {
						// Facebook Login
					}

					socialButton(
						image: ImageAsset.google.view,
						title: TextsConst.googleText
					) {
						// Google Login
					}
				}

				// MARK: - Switch Auth Type
				HStack(spacing: Numbers.five) {

					Text(type.accountPromptText)
						.foregroundStyle(
							Colors.whiteFFFFFF.opacity(
								Numbers.pointFive
							)
						)
						.font(
							FontsConst.extraBold(
								Numbers.forteen
							)
						)

					Button {
						selectedAuthType =
								type == .login
								? .signup
								: .login
					} label: {
						Text(type.alternateActionTitle)
							.foregroundStyle(
								Colors.redED1B24
							)
							.font(
								FontsConst.extraBold(
									Numbers.forteen
								)
							)
					}
				}
				.padding(.top, Numbers.twentyFour)
			}
			.padding(.horizontal, Numbers.thirty)
			.frame(maxWidth: .infinity)
		}
		.background(
			Colors.black1E1E1E
				.ignoresSafeArea()
		)
		.navigationBarBackButtonHidden(true)
	}

	// MARK: -  Button Actions(login/ sign up)

	private func handleAction() {
		switch type {
		case .login:
			print("Login API")

		case .signup:
			print("Signup API")
		}
	}

	// MARK: - social button(google/facebook)
	private func socialButton(
		image: Image,
		title: String,
		action: @escaping () -> Void
	) -> some View {

		Button(action: action) {
			HStack(spacing: Numbers.ten) {
				image
					.resizable()
					.scaledToFit()
					.frame(
						width: Numbers.fourty,
						height: Numbers.fourty
					)
				Text(title)
					.font(
						FontsConst.semiBold(
							Numbers.forteen
						)
					)
					.foregroundStyle(
						Colors.black1E1E1E
					)
			}
			.padding(.horizontal, Numbers.ten)
			.padding(.vertical, Numbers.ten)
			.background(Colors.whiteFFFFFF)
			.frame(
				width: Numbers.oneFifty,
				height: Numbers.fifty
			)
		}
	}
}

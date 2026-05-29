//
//  TextfieldView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 27/05/26.
//

import SwiftUI

/// A reusable customizable text field component that supports:
/// - Standard text input
/// - Secure password input
/// - Show/Hide password toggle
/// - Custom placeholder styling
/// - Keyboard type configuration
///
/// This component is designed to be scalable and reusable across multiple screens.
///
/// Example usage:
/// ```swift
/// ReusableTextField(
///     text: $email,
///     placeholder: "Enter Email",
///     isPasswordField: false,
///     keyboardType: .emailAddress
/// )
/// ```
struct ReusableTextField: View {

	/// Binding value used to store and update text entered by the user.
	@Binding var text: String

	/// Placeholder text displayed when the text field is empty.
	let placeholder: String

	/// Determines whether the field should behave as a secure password field.
	///
	/// - `true` → Uses `SecureField`
	/// - `false` → Uses regular `TextField`
	let isPasswordField: Bool

	/// Keyboard type displayed while entering text.
	///
	/// Example:
	/// - `.emailAddress`
	/// - `.numberPad`
	/// - `.phonePad`
	let keyboardType: UIKeyboardType

	/// Maintains the visibility state of secure text entry.
	///
	/// - `true` → Password hidden
	/// - `false` → Password visible
	@State private var isSecure = true

	var body: some View {
		HStack {
			// MARK: - Text Input Field
			Group {
				if isPasswordField && isSecure {

					/// Secure text input field for password entry.
					SecureField("", text: $text)
						.textFieldStyle(.plain)
						.font(FontsConst.medium(Numbers.forteen))

				} else {

					/// Standard text input field.
					TextField("", text: $text)
						.textFieldStyle(.plain)
						.font(FontsConst.medium(Numbers.forteen))
				}
			}
			.keyboardType(keyboardType)

			// MARK: - Show / Hide Password Button
			if isPasswordField {
				Button {

					/// Toggles password visibility.
					isSecure.toggle()

				} label: {
					Text(
						isSecure
						? TextsConst.showButtonText
						: TextsConst.hideButtonText
					)
					.font(FontsConst.semiBold(Numbers.twelve))
					.foregroundColor(Colors.grey70)
				}
			}
		}

		// MARK: - Custom Placeholder
		.overlay(alignment: .leading) {
			if text.isEmpty {
				Text(placeholder)
					.font(FontsConst.semiBold(Numbers.forteen))
					.foregroundStyle(Colors.grey50)
					.allowsHitTesting(false)
					.padding(.leading, Numbers.two)
			}
		}

		// MARK: - Styling
		.padding(.horizontal, Numbers.sixteen)
		.frame(height: Numbers.fifty)
		.background(Colors.whiteFFFFFF)
	}
}

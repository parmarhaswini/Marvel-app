//
//  FormView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 26/05/26.
//
//  This file contains the FormView and FormFieldModel definitions used to render
//  dynamic forms with customizable text fields.
//

import SwiftUI

/**
 A model representing a single form field with associated properties.

 This struct holds the data required to configure a text field within a form,
 including placeholder text, whether the field is for password input, keyboard type,
 and a binding to the input text.
 */
struct FormFieldModel: Identifiable {

	/// Unique identifier for each form field.
	let id = UUID()

	/// Placeholder text displayed in the input field.
	let placeholder: String

	/// Indicates if the field should obscure input text (for passwords).
	let isPasswordField: Bool

	/// Keyboard type to use when editing this field.
	let keyboardType: UIKeyboardType

	/// Binding to the text value entered by the user.
	var text: Binding<String>
}


/**
 A SwiftUI view that renders a scrollable form consisting of multiple form fields.

 This view takes an array of FormFieldModel objects and dynamically generates
 text fields for each one, allowing user input according to each field's configuration.
 */
struct FormView: View {

	/// An array of form field models to render in the form.
	let fields: [FormFieldModel]

	var body: some View {

		ScrollView {
			VStack(spacing: Numbers.sixteen) {

				// Render a reusable text field for each form field model provided.
				ForEach(fields) { field in

					ReusableTextField(
						text: field.text,
						placeholder: field.placeholder,
						isPasswordField: field.isPasswordField,
						keyboardType: field.keyboardType
					)
				}
			}
			.frame(maxWidth: .infinity)
		}
	}
}

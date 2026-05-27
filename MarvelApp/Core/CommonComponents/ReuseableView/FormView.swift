//
//  FormView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 26/05/26.
//

import SwiftUI

struct FormView: View {
	let title: String
	let placeholderText: String

	let buttonStyle: ButtonStyle
	let action: () -> Void
	var body: some View {
		ScrollView {
			VStack(spacing: Numbers.sixteen) {
				ImageAsset.launchscreenImage.view
					.resizable()
					.scaledToFit()
					.frame(
						width: Numbers.oneEightyEight,
						height: Numbers.oneFourty
					)
				

			}
			.padding()
			.frame(maxWidth: .infinity)
		}
		.background(Colors.black1E1E1E.ignoresSafeArea())
	}
}

#Preview {
	FormView(title: "String", placeholderText: "", buttonStyle: ButtonStyle.bordered) {

	}
}

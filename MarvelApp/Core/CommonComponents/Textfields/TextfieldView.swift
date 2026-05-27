//
//  TextfieldView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 27/05/26.
//

import SwiftUI

struct ReusableTextField: View {
	let placeholder: String
	@Binding var text: String
	var body: some View {
		TextField(placeholder, text: $text)
			.padding()
			.frame(maxWidth: .infinity, minHeight: 60)
			.background(Color.white)
			.cornerRadius(8)
			.border(Color.gray, width: 1)
			.padding([.horizontal])
	}
}

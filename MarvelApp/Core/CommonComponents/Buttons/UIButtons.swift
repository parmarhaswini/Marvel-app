//
//  UIButtons.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 26/05/26.
//

import Foundation
import SwiftUI

enum ButtonStyle {
	case filled
	case bordered
}

struct UIButtons: View {

	let title: String

	// Styling
	var font: Font = FontsConst.bold(20)
	var textColor: Color = Colors.whiteFFFFFF
	var backgroundColor: Color = Colors.redED1B24
	var borderColor: Color = Colors.redED1B24
	var borderWidth: CGFloat = Numbers.eight
	var cornerRadius: CGFloat = 0
	var height: CGFloat = Numbers.fifty

	let style: ButtonStyle
	let action: () -> Void

	var body: some View {

		Button(action: action) {

			Text(title)
				.font(font)
				.foregroundColor(textColor)
				.frame(maxWidth: .infinity)
				.frame(height: height)
				.background(
					style == .filled
					? backgroundColor
					: Color.clear
				)
				.overlay {

					if style == .bordered {

						RoundedRectangle(
							cornerRadius: cornerRadius
						)
						.stroke(
							borderColor,
							lineWidth: borderWidth
						)
					}
				}
				.cornerRadius(cornerRadius)
		}
	}
}

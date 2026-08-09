//
//  AuthType.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 28/05/26.
//

import Foundation


enum AuthType {

	case login
	case signup

	var buttonTitle: String {
		switch self {
		case .login:
			return TextsConst.loginText
		case .signup:
			return TextsConst.signUpText
		}
	}

	var accountPromptText: String {
		switch self {
		case .login:
			return TextsConst.dontHaveAnAccountText

		case .signup:
			return TextsConst.alreadyHaveAnAccountText
		}
	}

	var alternateActionTitle: String {
		switch self {
		case .login:
			return TextsConst.signUpText

		case .signup:
			return TextsConst.loginText
		}
	}
}

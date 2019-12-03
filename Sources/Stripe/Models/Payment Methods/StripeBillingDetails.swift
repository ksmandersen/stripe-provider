//
//  StripeBillingDetails.swift
//  Stripe
//
//  Created by Kristian Andersen on 03/12/2019.
//

import Foundation

public struct StripeBillingDetails: StripeModel {
	/// Billing address.
	public var address: StripeAddress?
	/// Email address.
	public var email: String?
	/// Full name.
	public var name: String?
	/// Billing phone number (including extension).
	public var phone: String?
}


import Foundation
import SwiftyJSON

struct User {

	let id: Int?
	let name: String?
	let email: String?
	let emailVerifiedAt: Any?
	let apiToken: String?
	let rateLimit: String?
	let walletBalance: Int?
	let facebook: Int?
	let google: Int?
	let twitter: Int?
	let userType: String?
	let deletedAt: Any?
	let createdAt: String?
	let updatedAt: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		name = json["name"].stringValue
		email = json["email"].stringValue
		emailVerifiedAt = json["email_verified_at"]
		apiToken = json["api_token"].stringValue
		rateLimit = json["rate_limit"].stringValue
		walletBalance = json["wallet_balance"].intValue
		facebook = json["facebook"].intValue
		google = json["google"].intValue
		twitter = json["twitter"].intValue
		userType = json["user_type"].stringValue
		deletedAt = json["deleted_at"]
		createdAt = json["created_at"].stringValue
		updatedAt = json["updated_at"].stringValue
	}

}

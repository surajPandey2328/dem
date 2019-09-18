
import Foundation
import SwiftyJSON

struct RootClass {

	let success: Bool?
	let kstream: Kstream?

	init(_ json: JSON) {
		success = json["success"].boolValue
		kstream = Kstream(json["kstream"])
	}

}

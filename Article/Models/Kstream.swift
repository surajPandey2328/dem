
import Foundation
import SwiftyJSON

struct Kstream {

	let currentPage: Int?
	let streamData: [StreamData]?
	let firstPageUrl: String?
	let from: Int?
	let nextPageUrl: String?
	let path: String?
	let perPage: Int?
	let prevPageUrl: Any?
	let to: Int?

	init(_ json: JSON) {
		currentPage = json["current_page"].intValue
		streamData = json["data"].arrayValue.map { StreamData($0) }
		firstPageUrl = json["first_page_url"].stringValue
		from = json["from"].intValue
		nextPageUrl = json["next_page_url"].stringValue
		path = json["path"].stringValue
		perPage = json["per_page"].intValue
		prevPageUrl = json["prev_page_url"]
		to = json["to"].intValue
	}

}


import Foundation
import SwiftyJSON

struct StreamData {

	let id: Int?
	let rssSourceId: Int?
	let title: String?
	let titleImage: String?
	let tagLine: String?
	let shortDescription: Any?
	let fullDescription: String?
	let titleImageUrl: Any?
	let descriptionImageUrl: String?
	let articleUrl: String?
	let author: Any?
	let articleType: String?
	let publishedDate: String?
	let isSponsored: Int?
	let isPremium: Int?
	let tags: Any?
	let filtertags: Any?
	let likes: Int?
	let comments: Int?
	let shares: Int?
	let metaKstreamId: Int?
	let accepted: Int?
	let createdAt: Any?
	let updatedAt: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		rssSourceId = json["rss_source_id"].intValue
		title = json["title"].stringValue
		titleImage = json["title_image"].stringValue
		tagLine = json["tag_line"].stringValue
		shortDescription = json["short_description"]
		fullDescription = json["full_description"].stringValue
		titleImageUrl = json["title_image_url"]
		descriptionImageUrl = json["description_image_url"].stringValue
		articleUrl = json["article_url"].stringValue
		author = json["author"]
		articleType = json["article_type"].stringValue
		publishedDate = json["published_date"].stringValue
		isSponsored = json["is_sponsored"].intValue
		isPremium = json["is_premium"].intValue
		tags = json["tags"]
		filtertags = json["filtertags"]
		likes = json["likes"].intValue
		comments = json["comments"].intValue
		shares = json["shares"].intValue
		metaKstreamId = json["meta_kstream_id"].intValue
		accepted = json["accepted"].intValue
		createdAt = json["created_at"]
		updatedAt = json["updated_at"].stringValue
	}

}

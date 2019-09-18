
import Foundation
import SwiftyJSON

struct GetArticlesList {
    
    let status: String?
    let copyright: String?
    let response: Response?
    
    init(_ json: JSON) {
        status = json["status"].stringValue
        copyright = json["copyright"].stringValue
        response = Response(json["response"])
    }
    
}

struct Response {
    
    let docs: [Docs]?
    let meta: Meta?
    
    init(_ json: JSON) {
        docs = json["docs"].arrayValue.map { Docs($0) }
        meta = Meta(json["meta"])
    }
    
}

struct Docs {
    
    let webUrl: String?
    let snippet: String?
    let leadParagraph: String?
    let abstract: String?
    let printPage: String?
   
    let source: String?
    let multimedia: [Multimedia]?
    let headline: Headline?
    let keywords: [Keywords]?
    let pubDate: String?
    let documentType: String?
    let newsDesk: String?
    let sectionName: String?
    let byline: Byline?
    let typeOfMaterial: String?
    let Id: String?
    let wordCount: Int?
    let uri: String?
    
    init(_ json: JSON) {
        webUrl = json["web_url"].stringValue
        snippet = json["snippet"].stringValue
        leadParagraph = json["lead_paragraph"].stringValue
        abstract = json["abstract"].stringValue
        printPage = json["print_page"].stringValue
        source = json["source"].stringValue
        multimedia = json["multimedia"].arrayValue.map { Multimedia($0) }
        headline = Headline(json["headline"])
        keywords = json["keywords"].arrayValue.map { Keywords($0) }
        pubDate = json["pub_date"].stringValue
        documentType = json["document_type"].stringValue
        newsDesk = json["news_desk"].stringValue
        sectionName = json["section_name"].stringValue
        byline = Byline(json["byline"])
        typeOfMaterial = json["type_of_material"].stringValue
        Id = json["_id"].stringValue
        wordCount = json["word_count"].intValue
        uri = json["uri"].stringValue
    }
    
}



struct Multimedia {
    
    let rank: Int?
    let subtype: String?
    let caption: Any?
    let credit: Any?
    let type: String?
    let url: String?
    let height: Int?
    let width: Int?
    let legacy: Legacy?
    let subType: String?
    let cropName: String?
    
    init(_ json: JSON) {
        rank = json["rank"].intValue
        subtype = json["subtype"].stringValue
        caption = json["caption"]
        credit = json["credit"]
        type = json["type"].stringValue
        url = json["url"].stringValue
        height = json["height"].intValue
        width = json["width"].intValue
        legacy = Legacy(json["legacy"])
        subType = json["subType"].stringValue
        cropName = json["crop_name"].stringValue
    }
    
}

struct Legacy {
    
    let xlarge: String?
    let xlargewidth: Int?
    let xlargeheight: Int?
    
    init(_ json: JSON) {
        xlarge = json["xlarge"].stringValue
        xlargewidth = json["xlargewidth"].intValue
        xlargeheight = json["xlargeheight"].intValue
    }
    
}

struct Headline {
    
    let main: String?
    let kicker: Any?
    let contentKicker: Any?
    let printHeadline: String?
    let name: String?
    let seo: Any?
    let sub: Any?
    
    init(_ json: JSON) {
        main = json["main"].stringValue
        kicker = json["kicker"]
        contentKicker = json["content_kicker"]
        printHeadline = json["print_headline"].stringValue
        name = json["name"].stringValue
        seo = json["seo"]
        sub = json["sub"]
    }
    
}

struct Keywords {
    
    let name: String?
    let value: String?
    let rank: Int?
    let major: String?
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        value = json["value"].stringValue
        rank = json["rank"].intValue
        major = json["major"].stringValue
    }
    
}

struct Byline {
    
    let original: String?
    let person: [Any]?
    let organization: String?
    
    init(_ json: JSON) {
        original = json["original"].stringValue
        person = json["person"].arrayValue.map { $0 }
        organization = json["organization"].stringValue
    }
    
}

struct Meta {
    
    let hits: Int?
    let offset: Int?
    let time: Int?
    
    init(_ json: JSON) {
        hits = json["hits"].intValue
        offset = json["offset"].intValue
        time = json["time"].intValue
    }
    
}

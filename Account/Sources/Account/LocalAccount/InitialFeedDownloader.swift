//
//  InitialFeedDownloader.swift
//  NetNewsWire
//
//  Created by Brent Simmons on 9/3/16.
//  Copyright © 2016 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import Parser
import Web

struct InitialFeedDownloader {

	static func download(_ url: URL) async -> ParsedFeed? {

		await withCheckedContinuation { continuation in
			self.download(url) { parsedFeed in
				continuation.resume(returning: parsedFeed)
			}
		}
	}

	static func download(_ url: URL,_ completion: @escaping (_ parsedFeed: ParsedFeed?) -> Void) {

		downloadUsingCache(url) { (data, response, error) in
			guard let data = data else {
				completion(nil)
				return
			}

			let parserData = ParserData(url: url.absoluteString, data: data)
			FeedParser.parse(parserData) { (parsedFeed, error) in
				completion(parsedFeed)
			}
		}
	}
}

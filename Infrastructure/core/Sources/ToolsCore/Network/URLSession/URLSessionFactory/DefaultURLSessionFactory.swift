//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public struct DefaultURLSessionFactory: URLSessionFactory {
	public init() {}

	public func make() -> URLSession {
		let urlSessionConfiguration = URLSessionConfiguration.default
		urlSessionConfiguration.timeoutIntervalForRequest = 500
		return URLSession(configuration: urlSessionConfiguration)
	}
}

//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public protocol URLRequestFactory {
	func make(with url: URL, method: HTTPMethod) -> URLRequest
}

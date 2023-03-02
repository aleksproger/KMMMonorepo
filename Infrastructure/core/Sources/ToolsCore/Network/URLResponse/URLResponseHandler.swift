//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public protocol URLResponseHandler {
	func handle(response: URLResponse, from: URL) throws
}

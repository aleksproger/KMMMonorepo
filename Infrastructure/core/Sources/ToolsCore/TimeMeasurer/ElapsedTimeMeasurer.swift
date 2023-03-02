//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public protocol ElapsedTimeMeasurer {
	func measure(_ block: () throws -> Void) rethrows -> TimeInterval
	func measure(_ block: () async throws -> Void) async rethrows -> TimeInterval
}

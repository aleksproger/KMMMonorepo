//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation

public struct TestError: LocalizedError {
	public private(set) var errorDescription: String?

	public init(description: String = "mock") {
		self.errorDescription = description
	}
}

//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation

extension Error {
	public var localizedErrorDescription: String {
		let error = self as? LocalizedError
		return error?.errorDescription ?? self.localizedDescription
	}
}

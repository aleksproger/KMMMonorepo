//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import PathKit
import XcodeProj

final class XcodeProjValidatorImpl: XcodeProjValidator {
	@discardableResult
	func isValid(path: Path) -> Result<Bool, Error> {
		do {
			_ = try XcodeProj(path: path)
			return .success(true)
		} catch {
			return .failure(error)
		}
	}
}
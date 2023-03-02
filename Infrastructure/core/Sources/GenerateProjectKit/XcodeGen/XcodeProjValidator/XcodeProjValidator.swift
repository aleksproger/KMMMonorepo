//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import PathKit
import XcodeProj

protocol XcodeProjValidator {
	@discardableResult
	func isValid(path: Path) -> Result<Bool, Error>
}

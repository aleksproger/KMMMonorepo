//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import JSONUtilities
import ProjectSpec

final class ProjectValidatorImpl: ProjectValidator {
	func validate(info: ProjectInfo) -> Result<Void, Error> {
		do {
			try info.projectDict.validateWarnings()
			try info.project.validateMinimumXcodeGenVersion("2.28.0")
			try info.project.validate()
			return .success(())
		} catch {
			return .failure(error)
		}
	}
}

extension Dictionary where Key == String, Value: Any {
	fileprivate func validateWarnings() throws {
		let errors: [SpecValidationError.ValidationError] = []

		if !errors.isEmpty {
			throw SpecValidationError(errors: errors)
		}
	}

	fileprivate func hasValueContaining(_ needle: String) -> Bool {
		values.contains { value in
			switch value {
			case let dictionary as JSONDictionary:
				return dictionary.hasValueContaining(needle)
			case let string as String:
				return string.contains(needle)
			case let array as [JSONDictionary]:
				return array.contains { $0.hasValueContaining(needle) }
			case let array as [String]:
				return array.contains { $0.contains(needle) }
			default:
				return false
			}
		}
	}
}

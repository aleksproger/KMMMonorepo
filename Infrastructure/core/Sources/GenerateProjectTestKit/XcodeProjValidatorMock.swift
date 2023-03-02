//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import PathKit
import ToolsCoreTestKit

public final class XcodeProjValidatorMock: XcodeProjValidator {
	public enum Input: Equatable {
		case isValid(Path)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var isValidResult: Result<Bool, Error> = .failure(TestError())
	@discardableResult
	public func isValid(path: Path) -> Result<Bool, Error> {
		inputs.append(.isValid(path))
		return isValidResult
	}
}

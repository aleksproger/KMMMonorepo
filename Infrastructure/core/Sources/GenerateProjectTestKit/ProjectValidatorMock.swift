//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ToolsCoreTestKit

public final class ProjectValidatorMock: ProjectValidator {
	public enum Input: Equatable {
		case validate(ProjectInfo)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var validateResult: Result<Void, Error> = .failure(TestError(description: "mock"))
	public func validate(info: ProjectInfo) -> Result<Void, Error> {
		inputs.append(.validate(info))
		return validateResult
	}
}

//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ToolsCore
import ToolsCoreTestKit

public final class MarkingDFSFactoryMock: MarkingDFSFactory {
	public enum Input: Equatable {
		case make
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var makeResult = ThreeColoredDFSWithMarkers<ProjectConfig>(
		markableNodes: Set()
	)

	public func make(nodes _: [Node<ProjectConfig>]) async throws -> ThreeColoredDFSWithMarkers<ProjectConfig> {
		inputs.append(.make)
		return makeResult
	}
}

//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectGraphBuilderTestKit
import ToolsCoreTestKit
import XCTest

final class ProjectConfigBuilderImplTests: XCTestCase {
	private lazy var sut = ProjectConfigBuilderImpl(
		specLoader: specLoader,
		shell: ShellMock()
	)

	private let specLoader = ProjectSpecLoaderMock()

	func test_BuildConfig_LoadsSpec() {
		specLoader.loadResult = .success(.fixture())

		_ = sut.config("test")

		XCTAssertEqual(specLoader.inputs, [
			.loadSpec(path: .xcSpecPath("test")),
		])
	}

	func test_BuildConfig_SpecExists_ReturnsExpectedConfig() {
		specLoader.loadResult = .success(.fixture())

		let config = sut.config("test")

		XCTAssertEqual(
			config,
			ProjectConfig(
				projectInfo: .fixture(),
				directoryPath: .directoryPath("test"),
				cachePath: .xcCachePath("test"),
				quiet: false
			)
		)
	}
}

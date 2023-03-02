//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectGraphBuilderTestKit
import ToolsCoreTestKit
import XCTest

final class ProjectSpecLoaderImplTests: XCTestCase {
	private lazy var sut = ProjectSpecLoaderImpl(
		fileManager: fileManager,
		specLoader: specLoader,
		pathResolver: pathResolver,
		shell: shell
	)

	private let fileManager = FileManagerTwinMock()
	private let specLoader = SpecLoaderWrapperMock()
	private let pathResolver = ProjectPathResolverMock()
	private let shell = ShellMock()

	func test_LoadSpec_GetsTopLevelDirectory() {
		_ = sut.loadSpec(at: .rootRelative("path"))

		XCTAssertEqual(pathResolver.inputs, [.resolve(.rootRelative("path"))])
	}

	func test_LoadSpec_UsesFullPath_ToCheckFileExistence() {
		pathResolver.resolveResult = .success("topLevel/path")

		_ = sut.loadSpec(at: .rootRelative("path"))

		XCTAssertEqual(fileManager.inputs, [.fileExists(path: "topLevel/path")])
	}

	func test_LoadSpec_FileDoesNotExist_ReturnFailure() {
		fileManager.isFileExist = false

		let result = sut.loadSpec(at: .rootRelative("path"))

		XCTAssertThrowsError(try result.get())
	}

	func test_LoadSpec_UsesSpecLoader() {
		pathResolver.resolveResult = .success("topLevel/path")
		fileManager.isFileExist = true

		_ = sut.loadSpec(at: .rootRelative("path"))

		XCTAssertEqual(specLoader.inputs, [
			.loadProject(
				path: "topLevel/path",
				root: nil,
				variables: [:]
			),
		])
	}
}

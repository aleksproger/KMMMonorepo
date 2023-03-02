//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ProjectSpec
import ToolsCoreTestKit
import XcodeProj
import XCTest

final class ProjectGeneratorImplUnitTests: XCTestCase {
	private lazy var sut = ProjectGeneratorImpl(
		projectValidator: projectValidator,
		xcodeProjGenerator: xcodeProjGenerator,
		shell: ShellMock()
	)

	private let xcodeProjGenerator = XcodeProjGeneratorMock()
	private let projectValidator = ProjectValidatorMock()

	func test_GenerateProject_SpecLoadingSuccess_ValidatesProjectInfo() async {
		_ = try? sut.generateProject(using: .fixture())

		XCTAssertEqual(projectValidator.inputs, [
			.validate(.fixture()),
		])
	}

	func test_GenerateProject_ValidatesProjectInfo() async {
		_ = try? sut.generateProject(using: .fixture(projectInfo: .fixture()))

		XCTAssertEqual(projectValidator.inputs, [
			.validate(.fixture()),
		])
	}

	func test_GenerateProject_ValidationFailure_ThrowsError() async {
		projectValidator.validateResult = .failure(TestError(description: "mock"))

		XCTAssertThrowsError(try sut.generateProject(using: .fixture()))
	}

	func test_GenerateProject_ValidationSuccess_GeneratesXcodeProj() async {
		projectValidator.validateResult = .success(())

		_ = try? sut.generateProject(using: .fixture(directoryPath: .rootRelative("dir")))

		XCTAssertEqual(xcodeProjGenerator.inputs, [
			.generateXcodeProj(.fixture(), .rootRelative("dir")),
		])
	}

	func test_GenerateProject_XcodeProjGenerationFailure_ThrowsError() async {
		projectValidator.validateResult = .success(())

		XCTAssertThrowsError(try sut.generateProject(using: .fixture()))
	}
}

private enum Env {
	static let xcodeProj = XcodeProj(
		workspace: XCWorkspace(),
		pbxproj: PBXProj(),
		sharedData: nil
	)
}

//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ArgumentParser
import Foundation
import GenerateProjectKit
import ToolsCore

@main
struct GenerateProjectCommand: AsyncParsableCommand {
	@Flag(help: "Projects will be generated in parallel if fast mode is chosen, but this can be unstable.")
	var mode: XcodeGenMode = .fast

	@Argument
	var rootProject: String?

	static var configuration = CommandConfiguration(
		commandName: "generate_project",
		abstract: "Generate .xcodeproj files"
	)

	mutating func run() async throws {
		let xcodeGen = XcodeGen(rootProject: rootProject, mode: mode)
		try await xcodeGen.run()
	}
}

extension XcodeGenMode: EnumerableFlag {}

// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "Tools",
	platforms: [
		.macOS(.v10_15),
	],
	products: [
		.executable(name: "linter", targets: ["Linter"]),
		.library(name: "LinterKit", targets: ["LinterKit"]),
		.executable(name: "formatter", targets: ["Formatter"]),
		.library(name: "FormatterKit", targets: ["FormatterKit"]),
		.executable(name: "githooks", targets: ["GitHooks"]),
		.library(name: "GitHooksKit", targets: ["GitHooksKit"]),
		.library(name: "ToolsCore", targets: ["ToolsCore"]),
		.library(name: "ToolsCoreTestKit", targets: ["ToolsCoreTestKit"]),
		.library(name: "ProjectGraphBuilderKit", targets: ["ProjectGraphBuilderKit"]),
		.executable(name: "generate_project", targets: ["GenerateProject"]),
		.library(name: "GenerateProjectKit", targets: ["GenerateProjectKit"]),
	],
	dependencies: [
		.package(
			url: "https://github.com/apple/swift-argument-parser",
			.exact("1.1.2")
		),
		.package(
			url: "https://github.com/tuist/XcodeProj.git",
			.exact("8.8.0")
		),
		.package(
			url: "https://github.com/kotovmax/XcodeGen.git",
			revision: "74e99ecc514777f67676d3fa49bb8bd09875d1e4"
		),
		.package(
			url: "https://github.com/onevcat/Rainbow",
			.exact("3.2.0")
		),
	],
	targets: [
		.executableTarget(
			name: "Linter",
			dependencies: [
				"LinterKit",
				.product(
					name: "ArgumentParser",
					package: "swift-argument-parser"
				),
			]
		),
		.target(
			name: "LinterKit",
			dependencies: [
				"ToolsCore",
			]
		),
		.testTarget(
			name: "LinterKitTests",
			dependencies: [
				"LinterKit",
				"ToolsCore",
				"ToolsCoreTestKit",
			]
		),
		.executableTarget(
			name: "Formatter",
			dependencies: [
				"FormatterKit",
				.product(
					name: "ArgumentParser",
					package: "swift-argument-parser"
				),
			]
		),
		.target(
			name: "FormatterKit",
			dependencies: [
				"ToolsCore",
			]
		),
		.testTarget(
			name: "FormatterKitTests",
			dependencies: [
				"FormatterKit",
				"ToolsCore",
				"ToolsCoreTestKit",
			]
		),
		.executableTarget(
			name: "GitHooks",
			dependencies: [
				"GitHooksKit",
				"GenerateProjectKit",
				.product(
					name: "ArgumentParser",
					package: "swift-argument-parser"
				),
			]
		),
		.target(
			name: "GitHooksKit",
			dependencies: [
				"ToolsCore",
				"Linter",
				"Formatter",
			]
		),
		.testTarget(
			name: "GitHooksKitTests",
			dependencies: [
				"GitHooksKit",
				"ToolsCore",
				"ToolsCoreTestKit",
			]
		),
		.target(
			name: "ToolsCore",
			dependencies: []
		),
		.target(
			name: "ToolsCoreTestKit",
			dependencies: [
				"ToolsCore",
			]
		),
		.testTarget(
			name: "ToolsCoreTests",
			dependencies: [
				"ToolsCore",
				"ToolsCoreTestKit",
			]
		),
		.executableTarget(
			name: "GenerateProject",
			dependencies: [
				"GenerateProjectKit",
				.product(
					name: "ArgumentParser",
					package: "swift-argument-parser"
				),
			]
		),
		.target(
			name: "ProjectGraphBuilderKit",
			dependencies: [
				"ToolsCore",
				"Rainbow",
				.product(
					name: "XcodeGenKit",
					package: "XcodeGen"
				),
			]
		),
		.target(
			name: "ProjectGraphBuilderTestKit",
			dependencies: [
				"ProjectGraphBuilderKit",
				"ToolsCore",
				"ToolsCoreTestKit",
			]
		),
		.testTarget(
			name: "ProjectGraphBuilderKitTests",
			dependencies: [
				"ProjectGraphBuilderKit",
				"ProjectGraphBuilderTestKit",
				"ToolsCore",
				"ToolsCoreTestKit",
				"Rainbow",
				.product(
					name: "XcodeGenKit",
					package: "XcodeGen"
				),
			]
		),
		.target(
			name: "GenerateProjectKit",
			dependencies: [
				"ToolsCore",
				"ProjectGraphBuilderKit",
				"Rainbow",
				.product(
					name: "XcodeGenKit",
					package: "XcodeGen"
				),
			]
		),
		.target(
			name: "GenerateProjectTestKit",
			dependencies: [
				"GenerateProjectKit",
				"ToolsCore",
				"ToolsCoreTestKit",
				"ProjectGraphBuilderKit",
			]
		),
		.testTarget(
			name: "GenerateProjectKitTests",
			dependencies: [
				"GenerateProjectTestKit",
				"GenerateProjectKit",
				"ProjectGraphBuilderTestKit",
				"ProjectGraphBuilderKit",
				"ToolsCore",
				"ToolsCoreTestKit",
			],
			exclude: [
				"XcodeGen/ProjectGeneratorImplTests/TestData/project.yml",
				"XcodeGen/WorkspaceGeneratorImplTests/TestData/first_project.yml",
				"XcodeGen/WorkspaceGeneratorImplTests/TestData/second_project.yml",
				"XcodeGen/WorkspaceGeneratorImplTests/TestData/third_project.yml",
				"XcodeGen/WorkspaceGeneratorImplTests/TestData/modified_project.yml",
			]
		),
	]
)

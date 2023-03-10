load("@build_bazel_rules_apple//apple:apple.bzl", "apple_dynamic_xcframework_import")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_framework")

apple_dynamic_xcframework_import(
    name = "MultiplatformArchitectureXC",
    xcframework_imports = glob([".gradle_build/XCFrameworks/**/*.xcframework/**/*"]),
)

ios_framework(
    name = "MultiplatformArchitectureiOS",
    bundle_id = "Mobile.Architecture.MultiplatformArchitecture.iOS",
    families = ["iphone"],
    infoplists = [
        ":Utility/iOS-Info.plist",
    ],
    minimum_os_version = "15.0",
    deps = [
        ":MultiplatformArchitectureXC"
    ],
    visibility = ["//visibility:public"],
)
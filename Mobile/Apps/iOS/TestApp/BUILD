load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application", "ios_framework")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:apple.bzl", "apple_dynamic_xcframework_import")
load("@com_github_buildbuddy_io_rules_xcodeproj//xcodeproj:defs.bzl","top_level_target","xcodeproj")

swift_library(
    name = "Sources",
    srcs = glob(["Sources/**/*.swift"]),
    module_name = "Sources",
    visibility = ["//visibility:public"],
    deps = [
        "//Mobile/BeerGallery:BeerGalleryiOS"
    ],
)

ios_application(
    name = "TestApp",
    bundle_id = "com.example.TestApp",
    families = ["iphone"],
    infoplists = [":Sources/TestApp/Info.plist"],
    minimum_os_version = "15.0",
    deps = [
        ":Sources"
    ],
    frameworks = [
        "//Mobile/BeerGallery:BeerGalleryiOS"
    ],
)

xcodeproj(
    name = "GenerateTestAppXcodeProject",
    project_name = "TestApp-Bazel",
    tags = ["manual"],
    top_level_targets = [
        top_level_target(":TestApp", target_environments = ["simulator"]),
    ],
)
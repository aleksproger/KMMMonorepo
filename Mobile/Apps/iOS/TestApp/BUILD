load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application", "ios_framework")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:apple.bzl", "apple_dynamic_xcframework_import")
load("@com_github_buildbuddy_io_rules_xcodeproj//xcodeproj:defs.bzl","top_level_target","xcodeproj")

swift_library(
    name = "Application",
    srcs = glob(["Application/**/*.swift"]),
    module_name = "Application",
    visibility = ["//visibility:public"],
    deps = [
        "//Mobile/Libraries/Common/BeerGallery:BeerGalleryiOS",
        "//Mobile/Libraries/iOS/iOSArchitecture",
    ],
)

ios_application(
    name = "TestApp",
    bundle_id = "com.example.TestApp",
    families = ["iphone"],
    infoplists = [":Application/Info.plist"],
    minimum_os_version = "15.0",
    deps = [
        ":Application"
    ],
    frameworks = [
        "//Mobile/Libraries/Common/BeerGallery:BeerGalleryiOS"
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
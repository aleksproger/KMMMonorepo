load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application", "ios_framework")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:apple.bzl", "apple_dynamic_xcframework_import")



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
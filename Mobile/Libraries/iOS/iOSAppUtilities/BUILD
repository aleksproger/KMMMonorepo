load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "iOSAppUtilities",
    srcs = glob(["API/**/*.swift"]),
    module_name = "iOSAppUtilities",
    visibility = ["//visibility:public"],
    deps = [
        "//Mobile/Libraries/iOS/iOSStorage",
        "//Mobile/Libraries/iOS/iOSUI",
    ]
)
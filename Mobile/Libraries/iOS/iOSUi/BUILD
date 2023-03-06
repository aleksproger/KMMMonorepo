load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "iOSUI",
    srcs = glob(["API/**/*.swift"]),
    module_name = "iOSUI",
    visibility = ["//visibility:public"],
    deps = [
        "//Mobile/Libraries/iOS/iOSUtilities",
        "//Mobile/Libraries/iOS/iOSArchitecture",
    ]
)
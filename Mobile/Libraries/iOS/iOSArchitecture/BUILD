load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "API",
    srcs = glob(["API/**/*.swift"]),
    module_name = "iOSArchitectureAPI",
    visibility = ["//visibility:public"],
    deps = ["//Mobile/Libraries/iOS/iOSUtilities"]
)

swift_library(
    name = "Impl",
    srcs = glob(["Impl/**/*.swift"]),
    module_name = "iOSArchitectureImpl",
    visibility = [
        "//visibility:public"
    ],
    deps = [
        ":API",
        "//Mobile/Libraries/iOS/iOSUtilities",
    ]
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "iOSStorage",
    srcs = glob(["API/**/*.swift"]),
    module_name = "iOSStorage",
    visibility = ["//visibility:public"],
    deps = [
        "//Multiplatform/Storage:MultiplatformStorageiOS",
    ]
)
.PHONY: build_apps
build_apps: build_kmm
	@$(BAZEL) build :apps

.PHONY: build_libs
build_libs:
	@$(BAZEL) build :libs

.PHONY: build_kmm
build_kmm:
	@$(GRADLE) assembleXCFramework

.PHONY: rta # Run Test App
rta: build_kmm
	@$(BAZEL) run //Mobile/Apps/iOS/TestApp

GRADLE=./gradlew
BAZEL=bazelisk


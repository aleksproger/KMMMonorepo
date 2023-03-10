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
	@$(BAZEL) build //Mobile/Apps/iOS/TestApp
	@$(BAZEL) run //Mobile/Apps/iOS/TestApp

.PHONY: xcp # Run Test App
xcp:
	@$(BAZEL) run //Mobile/Apps/iOS/TestApp:GenerateTestAppXcodeProject
	xed .

GRADLE=./gradlew
BAZEL=bazelisk


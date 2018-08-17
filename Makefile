windows_EXE=.exe
windows_PLUGIN=-windows

.PHONY: zip
zip: darwin linux windows
	mkdir -p build/releases
	(cd build/linux; zip -r ../releases/dcos-test-cli.linux.zip .)
	(cd build/darwin; zip -r ../releases/dcos-test-cli.darwin.zip .)
	(cd build/windows; zip -r ../releases/dcos-test-cli.windows.zip .)

.PHONY: darwin linux windows
darwin linux windows:
	GOOS=$(@) go build -o build/$(@)/dcos-test$($(@)_EXE) ./main.go
	cp plugin$($(@)_PLUGIN).toml build/$(@)/plugin.toml

.PHONY: clean
clean:
	rm -rf build

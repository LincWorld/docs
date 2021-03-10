.DELETE_ON_ERROR:

BUILD_DIR := ./build
SRC_DIR := ./src

export PATH := .:./node_modules/.bin/:$(PATH)



.PHONY: all
all: clean api

CS = $(shell sha1sum $(SRC_DIR)/api/openapi.json | awk '{ print $$1 }')
api:
	@npm install swagger-ui-dist
	@cp node_modules/swagger-ui-dist/* $(BUILD_DIR)/api/
	@echo "s/https:\/\/petstore.swagger.io\/v2\/swagger.json/.\/openapi.json\?$(CS)/"
	@sed -i "s/https:\/\/petstore.swagger.io\/v2\/swagger.json/.\/openapi.json\?$(CS)/" $(BUILD_DIR)/api/index.html
	@cp $(SRC_DIR)/api/openapi.json $(BUILD_DIR)/api/openapi.json

# .PHONY: test
# test: $(BUILD_SCHEMA) lint
# 	@node test/test.js

# .PHONY: lint
# lint: $(ALL_JS) node_modules/.install
# 	@eslint $(ALL_JS);

.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/api

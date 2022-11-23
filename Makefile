graph:
	swift package show-dependencies --package-path ios/Modules/Root --format dot \
		| grep -v pointfree \
		| grep -v apple \
		| sed -Ee 's/\/Users\/fhdelrio\/Documents\/Develop\/CustomFeaturesApp\/Modules\///g' \
		| sed -Ee 's/\[label=".*\\n(.*)\\n.*"\]/\[label="\1"\]/g' \
		| dot -Tsvg -o graph.svg
server:
	npm start
setup:
	brew bundle
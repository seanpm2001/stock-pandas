files = stock_pandas test *.py
test_files = *
# test_files = cum_append

test:
	STOCK_PANDAS_COW=1 pytest -s -v test/test_$(test_files).py --doctest-modules --cov stock_pandas --cov-config=.coveragerc --cov-report term-missing

lint:
	@echo "\033[1m>> Running ruff... <<\033[0m"
	@ruff check $(files)
	@echo "\033[1m>> Running mypy... <<\033[0m"
	@mypy $(files)

fix:
	ruff check --fix $(files)

install:
	pip install -U .[dev]
	pip install -U -r docs/requirements.txt

report:
	codecov

.PHONY: build

build: stock_pandas
	rm -rf dist build
	make build-ext
	make build-pkg

build-pkg:
	@echo "\033[1m>> Building package... <<\033[0m"
	@python -m build --sdist --wheel

build-ext:
	@echo "\033[1m>> Building extension... <<\033[0m"
	@STOCK_PANDAS_BUILDING_EXT=1 python setup.py build_ext --inplace

build-doc:
	sphinx-build -b html docs build_docs

upload:
	twine upload --config-file ~/.pypirc -r pypi dist/*

publish:
	make build
	make upload

.PHONY: test build

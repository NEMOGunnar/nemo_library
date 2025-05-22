#!/bin/bash
set -e
set -o pipefail

# remove relicts
echo "🧹 Removing temporary test project directory..."
rm -rf unit-test-project

# Create and enter test project directory
echo "📦 Creating temporary test project..."
mkdir -p unit-test-project
mkdir unit-test-project/tests
mkdir unit-test-project/metadata_optimate
cp -r tests/* unit-test-project/tests/
cp -r metadata_optimate/* unit-test-project/metadata_optimate/
cd unit-test-project

# Create and activate virtual environment
python -m venv venv
source venv/bin/activate

echo "📥 Installing package from TestPyPI..."
pip install --upgrade pip
pip install --index-url https://test.pypi.org/simple/ nemo_library --extra-index-url https://pypi.org/simple
pip install pytest pytest-cov

echo "🧪 Running tests..."
pytest --cov=nemo_library -v -x --log-cli-level=INFO "$@"

# Deactivate and clean up
deactivate
cd ..

echo "🧹 Removing temporary test project directory..."
rm -rf unit-test-project

echo "✅ Test run completed successfully."
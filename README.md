
# HighStyleApparel

E-commerce Application

[**High Style Apparel**](https://www.highstyleapparel.net/)

[**Figma Design Prototype**](https://www.figma.com/design/yi6tvefkcD1WxriuLAUmQ9/highstyleapparel---App-Design?node-id=0-1&t=iQToCerPTWZhtY7s-1)

---

## 📌 Pre-Commit and Pre-Push Checklist
Before committing and pushing your code, follow these steps to ensure code quality and the functionality of the application:

### ✅ Running the Linter
Analyze the Dart code and ensure it follows style guidelines and best practices:

```sh
dart run dart_code_linter:metrics analyze . --fatal-style --reporter=html --output-directory=dart_lint_report --verbose
```

This will generate a report in the `dart_lint_report` directory, highlighting any style issues or lint errors.

### ✅ Running Integration Tests with Coverage
Run the integration tests and generate coverage:

```sh
dart run test_reporter -- flutter test integration_test --coverage
```

### 📂 Organizing Allure Results
Move the generated Allure results to a dedicated integration test results folder:

```sh
mv allure-results allure-results-integration-tests
```

### 📊 Generating an HTML Coverage Report
Generate an HTML coverage report from the integration tests:

```sh
genhtml coverage/lcov.info --output-directory=coverage/integration-test-lcov-report
```

### 📈 Creating an Allure Report
Generate the Allure report to visualize test results:

```sh
allure generate allure-results-integration-tests --single-file -o allure-report/integration-tests --clean
```

### 🚨 Ensure Integration Tests Pass
Make sure all integration tests pass successfully before proceeding. This ensures that the application continues to work as expected after any changes.

---

## 📂 Project Structure
This directory structure ensures that all test reports and coverage files are organized properly.
```
coverage/
│── integration-test-lcov-report/
allure-results-integration-tests/
allure-report/
│── integration-tests/
dart_lint_report/
```

---

## 🎯 Important Notes for Developers
- Ensure the necessary tools (`test_reporter`, `genhtml`, `allure`, and `dart_code_linter`) are installed before running the tests and linter.
- The coverage reports help identify untested code sections.
- Allure reports provide a detailed visual representation of test execution results.
- Maintain this structure to keep test reports well-organized and easy to navigate.

Happy Testing! 🚀

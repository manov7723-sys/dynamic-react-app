ACTION REQUIRED AFTER MERGE:

1. Run `npm install` in your project directory (locally or in CI) to regenerate node_modules and package-lock.json. This ensures `ajv@^6.12.6` is installed to resolve the build issue with react-scripts and ajv-keywords.

2. Commit the fresh package-lock.json if it's changed in your workflow/build context.

This should resolve:
Error: Cannot find module 'ajv/dist/compile/codegen'
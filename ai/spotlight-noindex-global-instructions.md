## macOS Spotlight no-index workflow

When the user provides a folder path and asks to stop/exclude/prevent Spotlight indexing for it, run:

```bash
spotlight-noindex "<folder-path>"
```

Rules:
- Verify the path is a folder before running.
- Quote the path safely.
- Do not run for files.
- If `spotlight-noindex` is unavailable, add `.metadata_never_index` inside the folder with `touch "<folder-path>/.metadata_never_index"`.
- If permission is denied, report the exact folder and ask for sudo/Finder approval.
- Report success/failure with the final path.

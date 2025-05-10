# bundle_resources_loader

**Flutter plugin for searching files inside the iOS app bundle by filename and/or extension.**

This plugin lets you **recursively search for files** bundled in your iOS app, for example:

- `.storekit` config files
- `.json`, `.txt`, `.csv` assets
- any resource added to `Copy Bundle Resources`

✅ Works on iOS  
✅ Filters by filename and extension  
✅ Returns full absolute file paths

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  bundle_resources_loader:
    git:
      url: https://github.com/mrololo/app_bundle_file_searcher.git
```

## Usage

Import the package:

```dart
import 'package:app_bundle_file_searcher/app_bundle_file_searcher.dart';
```

Example search:

```dart
final files = await BundleResourcesLoader().searchResources(
  fileExt: 'storekit',    // optional
  fileName: 'Premium',      // optional
);
print(files);
```

• If extension is omitted or '', it matches all extensions.
• If filename is omitted or '', it matches all filenames.

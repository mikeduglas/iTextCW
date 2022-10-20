v1.0.0.6 20.10.2022
- FIX: Incorrect determination of the total number of pages could lead to a crash.

v1.0.0.5 09.10.2022
- MergePDF now accepts a queue of files, allowing you merge any number of files at a time.
- Internal changes:
    - BSTRING parameters changed to STRINGs and CSTRINGs.
    - All MergePDF methods now call single exported function.
    - Checking file existence is moved to the dll.

v1.0.0.4 07.10.2022
- added RotatePDF methods.

v1.0.0.3 13.04.2022
- fixed the bug with single page documents.

v1.0.0.2 26.01.2021
- removed .NET 4.0 dependencies, now only .NET 2.0 is required.

v1.0.0.1 17.01.2021
- added MergePDF accepted 4 input files.

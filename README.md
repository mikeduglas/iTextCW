# iTextCW

The project enables some [iTextSharp](https://github.com/itext/itextsharp) functionality to Clarion.

### Installation.
- Download ZIP.
- Place libsrc/*.inc,*.clw files into %Clarion%/accessory/libsrc/win folder.
- Place lib/itextcw.lib into %Clarion%/accessory/lib folder.
- Place bin/*.dll files into your project folder.

### How to Merge PDF files.
See \examples\PDFMergeTest.clw  for details.

- Include 'iTextCW.inc'.
- Declare a variable of type TITextCW.
- Call MergePDF method.  


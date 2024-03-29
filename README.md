# iTextCW

The project enables some [iTextSharp](https://github.com/itext/itextsharp) functionality to Clarion.

### Requirements
- .NET 2.0
- Clarion 6.3 and higher

### Installation
- Download ZIP.
- Place libsrc/*.inc,*.clw files into %Clarion%/accessory/libsrc/win folder.
- Place lib/itextcw.lib into %Clarion%/accessory/lib folder.
- Place bin/*.dll files into your project folder.

### How to merge PDF files
See \examples\PDFMergeTest.clw  for details.

- Include 'iTextCW.inc'.
- Declare a variable pdfMerge of type TITextCW.
- Call one of MergePDF methods.  

### How to sign PDF file
See \examples\PDFSignTest.clw  for details.

- Include 'iTextCW.inc'.
- Declare a variable pdfSign of type TITextCW.
- Delare a variable sap of type TPdfSigAppearanceGrp:
```
sap   LIKE(TPdfSigAppearanceGrp)
```
- Declare a string to receive an error message.
- Set necessary sap fields.
- Call SignPDF method, passing input and output pdf file names, PKCS #12 file name, a password, signature appearance group, and append flag.  

Note: The certificate must be created with exported private key.

### How to rotate PDF files
See \examples\PDFRotateTest.clw  for details.

### Contacts
- mikeduglas@yandex.ru
- mikeduglas66@gmail.com


!** iTextSharp for Clarion
!** v1.0.0.5
!** mikeduglas@yandex.ru 2022

SigRenderingModeEnum          EQUATE(LONG)
SigRenderingMode::DESCRIPTION EQUATE(0)
SigRenderingMode::NAME_AND_DESCRIPTION    EQUATE(1)
SigRenderingMode::GRAPHIC     EQUATE(3)

TPdfSigAppearanceGrp          GROUP,TYPE
SignatureRenderingMode          SigRenderingModeEnum
SignatureCreator                STRING(64)
Contact                         STRING(64)
LocationCaption                 STRING(64)
Location                        STRING(64)
ReasonCaption                   STRING(64)
Reason                          STRING(64)
Visible                         BOOL
!- fields below work only for Visible = true
LLX                             LONG     !- lower left x
LLY                             LONG     !- lower left y
URX                             LONG     !- upper right x
URY                             LONG     !- upper right y
PageNum                         LONG
FieldName                       STRING(64)
ImageFile                       STRING(256)
                              END

TITextCW                      CLASS, TYPE, MODULE('itextcw.clw'), LINK('itextcw.clw')
MergePDF                        PROCEDURE(STRING pInFile1, STRING pInFile2, STRING pOutFile), BOOL, PROC
MergePDF                        PROCEDURE(STRING pInFile1, STRING pInFile2, STRING pInFile3, STRING pOutFile), BOOL, PROC
MergePDF                        PROCEDURE(STRING pInFile1, STRING pInFile2, STRING pInFile3, STRING pInFile4, STRING pOutFile), BOOL, PROC
MergePDF                        PROCEDURE(*QUEUE pInFiles, BYTE pFieldNo, STRING pOutFile), BOOL, PROC

SignPDF                         PROCEDURE(STRING pInputPDF, STRING pOutputPDF, STRING pCertFile, STRING pCertPassword, TPdfSigAppearanceGrp pAppearance, BOOL pAppend, *STRING pErrMsg), BOOL

!!!<summary>Rotate all pages.</summary>
!!!<param name="pInFile">Input file.</param>
!!!<param name="pOutFile">Output file.</param>
!!!<param name="pRotation">Rotation value: 0, 90, 180, 270.</param>
RotatePDF                       PROCEDURE(STRING pInFile, STRING pOutFile, LONG pRotation), BOOL, PROC
!!!<summary>Rotate the pages.</summary>
!!!<param name="pInFile">Input file.</param>
!!!<param name="pOutFile">Output file.</param>
!!!<param name="pRotation">Rotation value: 0, 90, 180, 270.</param>
!!!<param name="pPreferredOrientationIsPortrait">true if preferred orientation is Portrait, otherwise Landscape.</param>
!!!<remarks>If the page is already in preferred orientation, then it will not be rotated.</remarks>
RotatePDF                       PROCEDURE(STRING pInFile, STRING pOutFile, LONG pRotation, BOOL pPreferredOrientationIsPortrait), BOOL, PROC
                              END

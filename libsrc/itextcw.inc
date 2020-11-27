!** iTextSharp for Clarion
!** mikeduglas@yandex.ru 2020

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
ImageFile                       STRING(256)
                              END

TITextCW                      CLASS, TYPE, MODULE('itextcw.clw'), LINK('itextcw.clw')
MergePDF                        PROCEDURE(STRING inFile1, STRING inFile2, STRING outFile), BOOL, PROC
MergePDF                        PROCEDURE(STRING inFile1, STRING inFile2, STRING inFile3, STRING outFile), BOOL, PROC
SignPDF                         PROCEDURE(STRING inputPDF, STRING outputPDF, STRING certFile, STRING certPassword, TPdfSigAppearanceGrp pAppearance, BOOL pAppend, BOOL pVisible, *STRING pErrMsg), BOOL
                              END

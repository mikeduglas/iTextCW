!** iTextSharp for Clarion
!** v1.0.0.7
!** mikeduglas@yandex.ru 2024

  MEMBER

  PRAGMA('link(itextcw.lib)')

  INCLUDE('iTextCW.inc'), ONCE

_PdfSigAppearanceGrp          GROUP, TYPE
SignatureRenderingMode          LONG
LLX                             LONG    !- lower left x
LLY                             LONG    !- lower left y
URX                             LONG    !- upper right x
URY                             LONG    !- upper right y
PageNum                         LONG
l_SignatureCreator              LONG
SignatureCreator                BSTRING, OVER(l_SignatureCreator)
l_Contact                       LONG
Contact                         BSTRING, OVER(l_Contact)
l_LocationCaption               LONG
LocationCaption                 BSTRING, OVER(l_LocationCaption)
l_Location                      LONG
Location                        BSTRING, OVER(l_Location)
l_ReasonCaption                 LONG
ReasonCaption                   BSTRING, OVER(l_ReasonCaption)
l_Reason                        LONG
Reason                          BSTRING, OVER(l_Reason)
l_FieldName                     LONG
FieldName                       BSTRING, OVER(l_FieldName)
l_ImageFile                     LONG
ImageFile                       BSTRING, OVER(l_ImageFile)
Visible                         BYTE
                              END

  MAP
    MODULE('iTextCW prototypes')
      MergePDFArray(LONG inFiles, LONG pCount, LONG pStrSize, LONG outFile), BYTE, PASCAL, DLL(1), NAME('iTextCW_MergePDFArray')
      SetMergePDFCallback(LONG cbAddress), PASCAL, DLL(1), NAME('iTextCW_SetMergePDFCallback')
      SignPDF(LONG inputPDF, LONG outputPDF, LONG certFile, LONG certPassword, LONG pAppearance, BYTE pAppend, LONG pErrMsg, LONG pSize), BYTE, PASCAL, DLL(1), NAME('iTextCW_SignPDF')
      RotatePDF(LONG inputPDF, LONG outputPDF, LONG pRotation), BYTE, PASCAL, DLL(1), NAME('iTextCW_RotatePDF')
      RotatePDFIfNeeded(LONG inputPDF, LONG outputPDF, LONG pRotation, BYTE pPreferredOrientationIsPortrait), BYTE, PASCAL, DLL(1), NAME('iTextCW_RotatePDFIfNeeded')
    END
  END

typInPdfFiles                 QUEUE, TYPE
name                            STRING(FILE:MaxFilePath)
                              END


TITextCW.MergePDF             PROCEDURE(STRING pInFile1, STRING pInFile2, STRING pOutFile)
inFiles                         QUEUE(typInPdfFiles).
  CODE
  inFiles.name = CLIP(pInFile1); ADD(inFiles)
  inFiles.name = CLIP(pInFile2); ADD(inFiles)
  RETURN SELF.MergePDF(inFiles, 1, pOutFile)
  
TITextCW.MergePDF             PROCEDURE(STRING pInFile1, STRING pInFile2, STRING pInFile3, STRING pOutFile)
inFiles                         QUEUE(typInPdfFiles).
  CODE
  inFiles.name = CLIP(pInFile1); ADD(inFiles)
  inFiles.name = CLIP(pInFile2); ADD(inFiles)
  inFiles.name = CLIP(pInFile3); ADD(inFiles)
  RETURN SELF.MergePDF(inFiles, 1, pOutFile)
  
TITextCW.MergePDF             PROCEDURE(STRING pInFile1, STRING pInFile2, STRING pInFile3, STRING pInFile4, STRING pOutFile)
inFiles                         QUEUE(typInPdfFiles).
  CODE
  inFiles.name = CLIP(pInFile1); ADD(inFiles)
  inFiles.name = CLIP(pInFile2); ADD(inFiles)
  inFiles.name = CLIP(pInFile3); ADD(inFiles)
  inFiles.name = CLIP(pInFile4); ADD(inFiles)
  RETURN SELF.MergePDF(inFiles, 1, pOutFile)

TITextCW.MergePDF             PROCEDURE(*QUEUE pInFiles, BYTE pFieldNo, STRING pOutFile)
szInFiles                       CSTRING(FILE:MaxFilePath), DIM(RECORDS(pInFiles))
szOutFile                       CSTRING(FILE:MaxFilePath), AUTO
count                           LONG, AUTO
qRef                            ANY
i                               LONG, AUTO
  CODE
  LOOP i=1 TO RECORDS(pInFiles)
    GET(pInFiles, i)
    qRef &= WHAT(pInFiles, pFieldNo)
    IF NOT qRef &= NULL
      szInFiles[i] = CLIP(qRef)
    ELSE
      !- invalid field no
      RETURN FALSE
    END
  END
  
  szOutFile = CLIP(pOutFile)
  
  RETURN MergePDFArray(ADDRESS(szInFiles), MAXIMUM(szInFiles, 1), FILE:MaxFilePath, ADDRESS(szOutFile))

TITextCW.SetMergePDFCallback  PROCEDURE(LONG pCallbackAddress)
  CODE
  SetMergePDFCallback(pCallbackAddress)

TITextCW.SignPDF              PROCEDURE(STRING pInputPDF, STRING pOutputPDF, STRING pCertFile, STRING pCertPassword, TPdfSigAppearanceGrp pAppearance, BOOL pAppend, *STRING pErrMsg)
szInputPDF                      CSTRING(LEN(CLIP(pInputPDF))+1), AUTO
szOutputPDF                     CSTRING(LEN(CLIP(pOutputPDF))+1), AUTO
szCertFile                      CSTRING(LEN(CLIP(pCertFile))+1), AUTO
szCertPsw                       CSTRING(LEN(CLIP(pCertPassword))+1), AUTO
grp                             LIKE(_PdfSigAppearanceGrp)
  CODE
  CLEAR(pErrMsg)
  
  szInputPDF = CLIP(pInputPDF)
  szOutputPDF = CLIP(pOutputPDF)
  szCertFile = CLIP(pCertFile)
  szCertPsw = CLIP(pCertPassword)
  
  grp.SignatureRenderingMode = pAppearance.SignatureRenderingMode
  grp.SignatureCreator = CLIP(pAppearance.SignatureCreator)
  grp.Contact = CLIP(pAppearance.Contact)
  grp.LocationCaption = CLIP(pAppearance.LocationCaption)
  grp.Location = CLIP(pAppearance.Location)
  grp.ReasonCaption = CLIP(pAppearance.ReasonCaption)
  grp.Reason = CLIP(pAppearance.Reason)
  IF pAppearance.ImageFile
    grp.ImageFile = LONGPATH(pAppearance.ImageFile)
  END
  
  grp.Visible = pAppearance.Visible
  grp.LLX = pAppearance.LLX
  grp.LLY = pAppearance.LLY
  grp.URX = pAppearance.URX
  grp.URY = pAppearance.URY
  grp.PageNum = pAppearance.PageNum
  IF pAppearance.FieldName
    grp.FieldName = pAppearance.FieldName
  END
  
  IF grp.Visible AND grp.PageNum = 0
    grp.PageNum = 1
  END

  RETURN SignPDF(ADDRESS(szInputPDF), ADDRESS(szOutputPDF), ADDRESS(szCertFile), ADDRESS(szCertPsw), ADDRESS(grp), pAppend, ADDRESS(pErrMsg), SIZE(pErrMsg))

TITextCW.RotatePDF            PROCEDURE(STRING pInFile, STRING pOutFile, LONG pRotation)
szInFile                        CSTRING(LEN(CLIP(pInFile))+1), AUTO
szOutFile                       CSTRING(LEN(CLIP(pOutFile))+1), AUTO
  CODE
  szInFile = CLIP(pInFile)
  szOutFile = CLIP(pOutFile)
  RETURN RotatePDF(ADDRESS(szInFile), ADDRESS(szOutFile), pRotation)

TITextCW.RotatePDF            PROCEDURE(STRING pInFile, STRING pOutFile, LONG pRotation, BOOL pPreferredOrientationIsPortrait)
szInFile                        CSTRING(LEN(CLIP(pInFile))+1), AUTO
szOutFile                       CSTRING(LEN(CLIP(pOutFile))+1), AUTO
  CODE
  szInFile = CLIP(pInFile)
  szOutFile = CLIP(pOutFile)
  RETURN RotatePDFIfNeeded(ADDRESS(szInFile), ADDRESS(szOutFile), pRotation, pPreferredOrientationIsPortrait)

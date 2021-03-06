!** iTextSharp for Clarion
!** mikeduglas@yandex.ru 2020

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
      MergePDF2(BSTRING inFile1, BSTRING inFile2, BSTRING outFile), PASCAL, DLL(1), NAME('iTextCW_MergePDF2')
      MergePDF3(BSTRING inFile1, BSTRING inFile2, BSTRING inFile3, BSTRING outFile), PASCAL, DLL(1), NAME('iTextCW_MergePDF3')
      MergePDF4(BSTRING inFile1, BSTRING inFile2, BSTRING inFile3, BSTRING inFile4, BSTRING outFile), PASCAL, DLL(1), NAME('iTextCW_MergePDF4')
      SignPDF(BSTRING inputPDF, BSTRING outputPDF, BSTRING certFile, BSTRING certPassword, LONG pAppearance, BYTE pAppend, *BSTRING pErrMsg), BYTE, PASCAL, DLL(1), NAME('iTextCW_SignPDF')
    END
  END

TITextCW.MergePDF             PROCEDURE(STRING inFile1, STRING inFile2, STRING outFile)
  CODE
  IF NOT EXISTS(inFile1) OR NOT EXISTS(inFile2)
    RETURN FALSE
  END
  
  MergePDF2(LONGPATH(inFile1), LONGPATH(inFile2), LONGPATH(outFile))
  RETURN TRUE
  
TITextCW.MergePDF             PROCEDURE(STRING inFile1, STRING inFile2, STRING inFile3, STRING outFile)
  CODE
  IF NOT EXISTS(inFile1) OR NOT EXISTS(inFile2) OR NOT EXISTS(inFile3)
    RETURN FALSE
  END
  
  MergePDF3(LONGPATH(inFile1), LONGPATH(inFile2), LONGPATH(inFile3), LONGPATH(outFile))
  RETURN TRUE
  
TITextCW.MergePDF             PROCEDURE(STRING inFile1, STRING inFile2, STRING inFile3, STRING inFile4, STRING outFile)
  CODE
  IF NOT EXISTS(inFile1) OR NOT EXISTS(inFile2) OR NOT EXISTS(inFile3) OR NOT EXISTS(inFile4)
    RETURN FALSE
  END
  
  MergePDF4(LONGPATH(inFile1), LONGPATH(inFile2), LONGPATH(inFile3), LONGPATH(inFile4), LONGPATH(outFile))
  RETURN TRUE

TITextCW.SignPDF              PROCEDURE(STRING inputPDF, STRING outputPDF, STRING certFile, STRING certPassword, TPdfSigAppearanceGrp pAppearance, BOOL pAppend, *STRING pErrMsg)
grp                             LIKE(_PdfSigAppearanceGrp)
bsErrMsg                        BSTRING
  CODE
  IF NOT EXISTS(inputPDF) OR NOT EXISTS(certFile)
    RETURN FALSE
  END
  
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
  
  IF SignPDF(LONGPATH(inputPDF), LONGPATH(outputPDF), LONGPATH(certFile), CLIP(certPassword), ADDRESS(grp), pAppend, bsErrMsg)
    RETURN TRUE
  ELSE
    pErrMsg = bsErrMsg
    RETURN FALSE
  END

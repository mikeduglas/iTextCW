  PROGRAM

  INCLUDE('iTextCW.inc'), ONCE

  MAP
    INCLUDE('printf.inc'), ONCE
  END

pdfSign                       TITextCW
sap                           LIKE(TPdfSigAppearanceGrp)
sErrMsg                       STRING(256), AUTO

  CODE
  sap.SignatureCreator = 'Mike Duglas'
  sap.Reason = 'SignPDF test'
  sap.Contact = 'mikeduglas66@gmail.com'
  sap.Location = 'Moscow, Russia'
  sap.SignatureRenderingMode = SigRenderingMode::NAME_AND_DESCRIPTION
  sap.Visible = TRUE
  sap.LLX = 50
  sap.LLY = 20
  sap.URX = 550
  sap.URY = 100
  sap.PageNum = 1
  
  IF pdfSign.SignPDF('.\pdf\result.pdf', '.\pdf\result_sign.pdf', '.\certificates\Local.pfx', '12345', sap, FALSE, sErrMsg)
    MESSAGE('SignPDF complete!')
  ELSE
    MESSAGE(printf('SignPDF failed, error: %s', sErrMsg))
  END

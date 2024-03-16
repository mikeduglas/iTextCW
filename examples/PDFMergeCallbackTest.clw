  PROGRAM

  INCLUDE('iTextCW.inc'), ONCE

  MAP
    Test_Callback()
    INCLUDE('printf.inc'), ONCE
  END

  CODE
  Test_Callback()
  
    
Test_Callback                 PROCEDURE()
pdfMerge                        TITextCW
inFile1                         STRING(255), AUTO
inFile2                         STRING(255), AUTO
inFile3                         STRING(255), AUTO
inFile4                         STRING(255), AUTO
outFile                         STRING(255), AUTO
  MAP
    MergePDFCallback(BSTRING pFilename, LONG pPageNum, LONG pTotalPages),BYTE,PASCAL,PRIVATE
  END

  CODE
  
  pdfMerge.SetMergePDFCallback(ADDRESS(MergePDFCallback))
  
  inFile1 = '.\pdf\test 1.pdf'
  inFile2 = '.\pdf\test 2.pdf'
  inFile3 = '.\pdf\test 3.pdf'
  inFile4 = '.\pdf\test 4.pdf'
  outFile = '.\pdf\result_only_page_1.pdf'
  IF pdfMerge.MergePDF(inFile1, inFile2, inFile3, inFile4, outFile)
    MESSAGE('Complete!')
  ELSE
    MESSAGE('Fail!')
  END

MergePDFCallback              PROCEDURE(BSTRING pFilename, LONG pPageNum, LONG pTotalPages)
bDontMergeThisPage              BOOL(FALSE)
  CODE
  IF pPageNum=1
    printd('MergePDFCallback(%s, page %i of %i): ALLOWED', pFilename, pPageNum, pTotalPages)
  ELSE
    printd('MergePDFCallback(%s, page %i of %i): NOT ALLOWED', pFilename, pPageNum, pTotalPages)
    bDontMergeThisPage = TRUE  !- don't allow pages other than 1st one.
  END
  
  RETURN bDontMergeThisPage
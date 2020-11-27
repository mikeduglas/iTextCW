  PROGRAM

  INCLUDE('iTextCW.inc'), ONCE

  MAP
  END

pdfMerge                      TITextCW
inFile1                       STRING(255), AUTO
inFile2                       STRING(255), AUTO
outFile                       STRING(255), AUTO

  CODE
  inFile1 = '.\pdf\1.pdf'
  inFile2 = '.\pdf\2.pdf'
  outFile = '.\pdf\result.pdf'
  IF pdfMerge.MergePDF(inFile1, inFile2, outFile)
    MESSAGE('Complete!')
  ELSE
    MESSAGE('Fail!')
  END

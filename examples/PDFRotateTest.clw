  PROGRAM

  INCLUDE('iTextCW.inc'), ONCE

  MAP
  END

pdfMerge                      TITextCW
inFile                        STRING(255), AUTO
outFile                       STRING(255), AUTO

  CODE
  
  !- 1. Unconditionally rotate all pages 90 degrees clockwise
  inFile = '.\pdf\1.pdf'
  outFile = '.\pdf\Rotated 1.pdf'
  IF pdfMerge.RotatePDF(inFile, outFile, 90)
    MESSAGE('Complete!')
  ELSE
    MESSAGE('Fail!')
  END

  !- 2. Rotate 90 degrees clockwise only those pages which are in landscape orientation
  inFile = '.\pdf\2.pdf'
  outFile = '.\pdf\Rotated 2.pdf'
  IF pdfMerge.RotatePDF(inFile, outFile, 90, TRUE)
    MESSAGE('Complete!')
  ELSE
    MESSAGE('Fail!')
  END

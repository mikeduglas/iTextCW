  PROGRAM

  INCLUDE('iTextCW.inc'), ONCE

  MAP
  END

pdfMerge                      TITextCW
inFiles                       QUEUE, PRE(inFiles)
name                            STRING(256)
                              END
outFile                       STRING(256), AUTO

  CODE
  !- add source pdf files to the queue
  inFiles.name = '.\pdf\test 1.pdf'; ADD(inFiles)
  inFiles.name = '.\pdf\test 2.pdf'; ADD(inFiles)
  inFiles.name = '.\pdf\test 3.pdf'; ADD(inFiles)
  !- resulting pdf
  outFile = '.\pdf\result queue.pdf'
  !- merge all files (field #1 contains file names)
  IF pdfMerge.MergePDF(inFiles, 1, outFile)
    MESSAGE('Complete!')
  ELSE
    MESSAGE('Fail!')
  END

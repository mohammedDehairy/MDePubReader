MDePubReader
============

ePub Reader component for iOS

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Installation

1.drag the MDePubReaderViewController folder to your Project 

2. add QuartzCore.framework and libz.1.2.5.dylib to your project

3. disable ARC to XMLHandler.m ,ZipArchive.m,And ePubContent.m.



Use

- initialize MDePubReaderViewController with MDePubReaderViewController_iPhone xib file if you are using it in iphone 
or MDePubReaderViewController_iPad if you are using it in iPad.

-set _strFileName property of the MDePubReaderViewController instance to the ePub file name in the bundle 

- if the ePub file is in the documents Directory of the app set the MDePubReaderViewController FileInDocumentsDirectory 
Property to yes ,and set the _strFileName property to the ePub file path in the Documents directory

- THATS IT.



GOOD LUCK

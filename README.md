ps-unzip
========
ZIP extractor which uses native Windows ability to process ZIP packages. Depends on PowerShell.
'''
ps-unzip {'Extrach archive.zip':
	file		=> 'c:\temp\archive.zip',
	destination	=> 'c:\temp\archive'
}
'''
Will extract *archive.zip* to 'C:\temp\archive'

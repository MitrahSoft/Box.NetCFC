
<cfscript>

	boxStruct = application.objBox.publicShare(path_from = '/Documents/WordDocs', target = 'folder', password = '12@', message = 'Hi', emails = 'cfmitrah.test@yahoo.com' );
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>

<cfscript>

	boxStruct = application.objBox.privateShare(path_from : '/Documents/WordDocs', target : 'folder', message : 'Hi', emails : 'cfmitrah.test@yahoo.com', notify : 'true');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
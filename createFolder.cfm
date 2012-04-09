
<cfscript>

	boxStruct = application.objBox.createFolder(share : '1', path : '/Documents', folder_Name : 'WordDocs');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
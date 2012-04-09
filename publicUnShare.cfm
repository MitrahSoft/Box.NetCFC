
<cfscript>

	boxStruct = application.objBox.publicUnShare(path_from = '/Documents/WordDocs', target = 'folder');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
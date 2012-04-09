
<cfscript>

	boxStruct = application.objBox.delete(path_from : '/Documents/Files', target : 'folder');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
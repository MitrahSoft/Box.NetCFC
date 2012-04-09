
<cfscript>

	boxStruct = application.objBox.moveFolder(path_from :'/Files/Photos', path_to : '/New Folder', target : 'folder');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
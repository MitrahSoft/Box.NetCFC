
<cfscript>

	boxStruct = application.objBox.addTag( path_from = '/Documents/WordDocs', target = 'folder', tags = 'New Tag' );
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>
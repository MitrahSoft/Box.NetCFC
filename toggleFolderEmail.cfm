
<cfscript>

	boxStruct = application.objBox.togglefolderEmail( path_from = '/Documents/WordDocs', enable = '1');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
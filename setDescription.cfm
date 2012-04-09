
<cfscript>

	boxStruct = application.objBox.setDescription(path_from : '/Documents/WordDocs/Banner Fact.webdoc', target : 'file', description : 'banner doc');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>

<cfscript>

	boxStruct = application.objBox.copy(path_from :'/Documents/WordDocs/Banner Fact.webdoc', path_to : '/Files/', target : 'file');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
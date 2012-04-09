
<cfscript>

	boxStruct = application.objBox.getVersions( path_from : '/Documents/WordDocs/Banner Fact.webdoc', target : 'file');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>
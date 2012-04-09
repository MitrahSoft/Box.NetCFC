
<cfscript>

	boxStruct = application.objBox.getComments( path_from : '/Documents/WordDocs/Banner Fact.webdoc', target : 'file');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>
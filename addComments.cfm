
<cfscript>

	boxStruct = application.objBox.addComments( path_from : '/Documents/WordDocs/Banner Fact.webdoc', target : 'file', message : 'my comments');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>
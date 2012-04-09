
<cfscript>

	boxStruct = application.objBox.deleteComments( path_from : '/Documents/WordDocs/Banner Fact.webdoc', target : 'file');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>

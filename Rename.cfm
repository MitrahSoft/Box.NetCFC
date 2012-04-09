
<cfscript>

	boxStruct = application.objBox.rename(target : 'file', path_from : '/Files/Banner Fact.webdoc', name : 'Banner') ;
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>
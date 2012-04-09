
<cfscript>

	boxStruct = application.objBox.search( query : 'Documents', page : '1', per_page : '3', sort : 'name', direction : 'asc', params : 'show_path');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
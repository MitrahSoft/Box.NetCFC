
<cfscript>

	boxStruct = application.objBox.getFriends(params = 'nozip');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
<cfscript>

	boxStruct = application.objBox.getBoxDetails();
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
<cfscript>

	boxStruct = application.objBox.getBoxTree();
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
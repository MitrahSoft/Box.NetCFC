
<cfscript>

	boxStruct = application.objBox.exportTag();
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);

</cfscript>
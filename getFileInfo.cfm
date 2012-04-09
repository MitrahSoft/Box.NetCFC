
<cfscript>

	boxStruct = application.objBox.getFileInfo(path_from : '/Fact Doc.webdoc', target : 'file');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
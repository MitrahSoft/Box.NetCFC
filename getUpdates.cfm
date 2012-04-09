
<cfscript>

	boxStruct = application.objBox.getUpdates( begin_timestamp : '2011,05,10', params : 'no_zip');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
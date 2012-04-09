
<cfscript>

	boxStruct = application.objBox.addtoMybox( file_id : '739332156', public_name :'fic747zi8u', path_to : 'New Folder', tags : 'added');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>
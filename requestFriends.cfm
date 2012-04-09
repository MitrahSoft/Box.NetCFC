
<cfscript>

	boxStruct = application.objBox.requestFriends( message : 'Hi, Newly shared..', emails : 'cfmitrah.test@yahoo.com', params : 'no_email');
	xmlObj = xmlParse(boxStruct.filecontent);
	writeDump(xmlObj);
	
</cfscript>

<cfset boxStruct = application.objBox.currentVersions(path_from : '/Documents/WordDocs/Banner Fact.webdoc')>
<cfif isDefined('boxStruct.filecontent')>
	<cfset xmlObj = xmlParse(boxStruct.filecontent)>
	<cfdump var="#xmlObj#"><cfabort>
<cfelse>
	In Progress, To be completed....
</cfif>
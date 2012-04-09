<cfcomponent displayname="BoxCFC" output="false" >

	<cfset variables.instance = structNew() />
	
	<cffunction name="init" displayname="init" access="public" output="false" returntype="Any" >
		<cfargument name="Ticket" 		type="any" displayname="Ticket" />
		<cfargument name="auth_token" 	type="any" displayname="auth_token" />
		<cfargument name="api_key" 		type="any" default="" 							displayname="api_key" />
		<cfargument name="email" 		type="any" default="cfmitrah.test@yahoo.com" 	displayname="email" />
		<cfscript>
			setInstanceValue('api_key',  arguments.api_key);
			setInstanceValue('ticket',arguments.Ticket);
			setInstanceValue('auth_token',arguments.auth_token);
			setInstanceValue('email', arguments.email);
			setInstanceValue('apiURL','https://www.box.net/api/1.0/rest?');
			return this;
		</cfscript>
	</cffunction>
	
		<!--- Private Functions --->
	<cffunction name="setInstanceValue" displayname="setInstanceValue" description="A function to set instance values pairs" access="private" output="false" returntype="void">
		<cfargument name="key" 		type="string" 	required="true" 	displayname="structKey" 	hint="Key in the instance scope to set" />
		<cfargument name="value" 	type="string" 	required="true" 	displayname="structValue" 	hint="Value to set in the key" />
		<cfargument name="subkey" 	type="string" 	required="false" 	displayname="subKey" 		hint="The name of a sub key in the instance scope" default="" />
		<cfscript>
			var refInstance	= instance;
			if (arguments.subkey NEQ '')
			 	{
					refInstance	= instance[arguments.subkey];
				}
			refInstance[arguments.key]	= arguments.value;
		</cfscript>
	</cffunction>
	
	<cffunction name="getInstanceValue" displayname="getInstanceValue" description="A function to get instance values" access="private" output="false" returntype="any">
		<cfargument name="key" 		type="string" 	required="true" 	displayname="structKey" 	hint="Key in the instance scope to set" />
		<cfargument name="subkey" 	type="string" 	required="false" 	displayname="subKey" 		hint="The name of a sub key in the instance scope" default="" />
		<cfscript>
			var refInstance	= instance;
			if (arguments.subkey NEQ '')
			 {
				refInstance	= instance[arguments.subkey];
			 }
			return refInstance[arguments.key];
		</cfscript>
	</cffunction>
	
		<!--- Get Details of Box --->	
	<cffunction name="getBoxDetails" access="public" output="false" >
		<cfset var cfhttp	 = '' />
		<cfscript>
			var returnStruct	= {};
			var httpParameters	= {api_key=getInstanceValue('api_key'),auth_token=getInstanceValue('auth_token'),action='get_account_info'};
		</cfscript>	
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getBoxDetails">
		<cfreturn getBoxDetails />
	</cffunction>
	
		<!--- Box Tree --->	
	<cffunction name="getBoxTree" access="public" output="false" >
		<cfargument name="folderid" type="any" default="0" hint="Folder Id for Tree" />
		<cfset var cfhttp= '' />
		<cfscript>
			var returnStruct = {};
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='get_account_tree',
										 folder_id = '#arguments.folderid#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#&params[]=nozip" method="get" result="tree">
		<cfreturn tree />
	</cffunction>
	
		<!--- Create Folder --->
	<cffunction name="createFolder" access="public" output="false" >
		<cfargument name="path" 		type="any" 		hint="Parent Folder Id" />
		<cfargument name="folder_Name" 	type="any" 		hint="Name of the new folder" />
		<cfargument name="share" 		type="numeric" 	hint="set to allow folder to be shared" />
		<cfset var cfhttp= '' />
		<cfscript>
			var returnStruct = {};
			var parent = pathtoId(path : '#arguments.path#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='create_folder',
									parent_id='#parent#', name='#arguments.folder_Name#', share='#arguments.share#' };
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="newFolder">
		<cfreturn newFolder />
	</cffunction>

		<!--- Move Folder --->	
	<cffunction name="moveFolder" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="move to folder or file" />
		<cfargument name="path_from" 	type="any" hint="folder or file to move from target" />
		<cfargument name="path_to" 		type="any" hint="folder or file to move to destination" />
		<cfscript>
			var reqtarg = pathtoId (path : '#arguments.path_from#');
			var reqdest = pathtoId (path : '#arguments.path_to#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='move',
									target='#arguments.target#',target_id = '#reqtarg#',destination_id ='#reqdest#' };
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="moveFolder">
		<cfreturn moveFolder />
	</cffunction>
	
		<!--- Copy File--->
	<cffunction name="copy" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="copy to folder or file" />
		<cfargument name="path_from"	type="any" hint="path folder or file to move from target" />
		<cfargument name="path_to" 		type="any" hint="path folder or file to move to destination" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var reqdest = pathtoId(path : '#arguments.path_to#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='copy',
									target='#arguments.target#',target_id = '#reqtarg#',destination_id ='#reqdest#' };
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="copy" >
		<cfreturn copy />
	</cffunction>
	
		<!--- Rename File or Folder --->
	<cffunction name="rename" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="Rename folder or file" />
		<cfargument name="path_from" 	type="any" hint="path folder or file to Rename" />
		<cfargument name="name" 		type="any" hint="New name" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='rename',
									target='#arguments.target#',target_id = '#reqtarg#',new_name = '#arguments.name#' };
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURl')##buildParamString(httpParameters)#" method="get" result="rename">
		<cfreturn rename />
	</cffunction>
	
		<!--- Delete File or Folder --->
	<cffunction name="delete" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="Delete folder or file" />
		<cfargument name="path_from" 	type="any" hint="path of folder or file to Delete" />
		<cfscript>
			var reqtarg = pathtoId (path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='delete',
									target='#arguments.target#',target_id = '#reqtarg#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="delete">
		<cfreturn delete />
	</cffunction>
	
		<!--- Get File Info --->
	<cffunction name="getFileInfo" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="Info of folder or file" />
		<cfargument name="path_from" 	type="any" hint="path of file to Get Info" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'),action='get_file_info',
									file_id = '#reqtarg#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getFileInfo">
		<cfreturn getFileInfo />
	</cffunction>
	
		<!--- To set Description for file or folder --->
	<cffunction name="setDescription" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="Description to be set to folder or file" />
		<cfargument name="path_from" 	type="any" hint="Description to folder or file path" />
		<cfargument name="description" 	type="any" hint="Description of file or folder" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='set_description',
									target = '#arguments.target#', target_id = '#reqtarg#', description = '#arguments.description#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="setDescription">
		<cfreturn setDescription />
	</cffunction>
	
		<!--- To Public Share Folder or File--->
	<cffunction name="publicShare" access="public" output="false" >
		<cfargument name="target" 		type="any" hint="Folder or file to share" />
		<cfargument name="path_from" 	type="any" hint="path of folder or file to share" />
		<cfargument name="password" 	type="any" hint="The password to protect the folder or file" />
		<cfargument name="message" 		type="any" hint="A message to be included in a notification email" />
		<cfargument name="emails" 		type="any" hint="An array of emails for which to notify users about the newly shared file or folder" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='public_share',
									target = '#arguments.target#', target_id = '#reqtarg#', password = '#arguments.password#',
									message = '#arguments.message#', emails='#arguments.emails#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="publicShare">
		<cfreturn publicShare>
	</cffunction>
	
		<!--- To Public UnShare Folder or File--->
	<cffunction name="publicUnShare" access="public" description="To UnShare Folder or File">
		<cfargument name="target" 		type="any" hint="The folder or file to Public UnShare" />
		<cfargument name="path_from" 	type="any" hint="The folder or file path to Public UnShare" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#', type :'#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='public_unshare',
									target = '#arguments.target#', target_id = '#reqtarg#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="publicUnShare">
		<cfreturn publicUnShare />
	</cffunction>
	
		<!--- Get Friends --->
	<cffunction name="getFriends" access="public" description="To retrieve a list of the user's friends">
		<cfargument name="params" type="any" hint="additional, optional parameters" />
		<cfscript>
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='get_friends', params = '#arguments.params#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getFriends">
		<cfreturn getFriends />
	</cffunction>
	
		<!--- Add to my Box --->
	<cffunction name="addtoMybox" access="public" description="Copies a file shared by another individual, to a user's a designated folder in the user's Box">
		<cfargument name="file_id" 		type="any" hint="Id of file to add to box" />
		<cfargument name="public_name" 	type="any" hint="Public name of file to add to box" />
		<cfargument name="path_to" 		type="any" default="folder" 	hint="Path of folder to add" />
		<cfargument name="tags" 		type="any" hint="Array of tags to be added" />
		<cfscript>
			var folder_id = pathtoId(path : '#arguments.path_to#', type : 'folder');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='add_to_mybox', file_id='#arguments.file_id#',
										public_name='#arguments.public_name#', folder_id='#folder_id#' ,tags= '#arguments.tags#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="addtoMybox">
		<cfreturn addtoMybox />
	</cffunction>
	
		<!--- Toggle Folder email --->
	<cffunction name="togglefolderEmail" access="public" description="enables or disables the upload email address for a folder">
		<cfargument name="path_from" 	type="any" hint="Toggle email to folder" />
		<cfargument name="target" 		type="any" default="folder" hint="Target folder" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='toggle_folder_email',
									folder_id = '#reqtarg#', enable='#arguments.enable#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="togglefolderEmail">
		<cfreturn togglefolderEmail />
	</cffunction>
	
		<!--- Add Tag --->
	<cffunction name="addTag" access="public" description="applies a tag or tags to a designated file or folder">
		<cfargument name="path_from" 	type="any" hint="Tag to folder or file path" />
		<cfargument name="target" 		type="any" hint="Target folder or file" />
		<cfargument name="tags" 		type="any" hint="Tags to add" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='add_to_tag',
									target_id = '#reqtarg#', target = '#arguments.target#', tags='#arguments.tags#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="addTag">
		<cfreturn addTag />
	</cffunction>
	
		<!--- Export Tag --->
	<cffunction name="exportTag" access="public" description="returns all the tags in a user's account">
		<cfscript>
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='export_tags'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="exportTag">
		<cfreturn exportTag />
	</cffunction>
	
		<!--- Get Comments --->
	<cffunction name="getComments" access="public" description="To retrieve the comments on an item">
		<cfargument name="path_from" 	type="any" hint="Get comment from folder or file path" />
		<cfargument name="target" 		type="any" hint="Target folder or file" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='get_comments',
									target_id = '#reqtarg#', target = '#arguments.target#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getComments">
		<cfreturn getComments />
	</cffunction>
	
		<!--- Add Comments --->
	<cffunction name="addComments" access="public" description="To retrieve the comments on an item">
		<cfargument name="path_from" 	type="any" 		hint="Add comment to folder or file path" />
		<cfargument name="target" 		type="any" 		hint="Target folder or file" />
		<cfargument name="message" 		type="string" 	hint="The comment's message to be displayed" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='add_comment',
									target_id = '#reqtarg#', target = '#arguments.target#', message = '#arguments.message#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getComments">
		<cfreturn getComments />
	</cffunction>
	
		<!--- Delete Comments --->
	<cffunction name="deleteComments" access="public" description="To retrieve the comments on an item">
		<cfargument name="path_from" 	type="any" hint="Delete comment of folder or file path" />
		<cfargument name="target" 		type="any" hint="Target folder or file" />
		<cfscript>
			var commentid = getComments(path_from :'#arguments.path_from#', target='#arguments.target#');
			commentid = xmlParse(commentid.Filecontent,false);
			xPath = "/response/comments/comment/comment_id/";
			targetid = xmlSearch(commentid,"#xPath#");
			target_id = targetid[1].XmlText;
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='delete_comment',
									target_id = '#target_id#', target = '#arguments.target#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="deleteComments">
		<cfreturn deleteComments />
	</cffunction>
	
		<!--- Search --->
	<cffunction name="search" access="public"  description="Search the given Query">
		<cfargument name="query" 		type="any" hint="Search Query" />
		<cfargument name="page" 		type="any" hint="The page number, which begins on page 1" />
		<cfargument name="per_page" 	type="any" hint="The number of search results to display per page" />
		<cfargument name="sort"			type="any" hint="The method in which the results may be sorted.Values can be 'relevance','name','date', or 'size'" />
		<cfargument name="direction" 	type="any" hint="Can specify whether to sort content order" />
		<cfargument name="params" 		type="any" hint="Allows to set additional, optional parameters: " />
		<cfscript>
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='search', direction = '#arguments.direction#',
									query = '#arguments.query#', page = '#arguments.page#', per_page = '#arguments.per_page#', sort = '#arguments.sort#', params = '#arguments.params#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="search">
		<cfreturn search>
	</cffunction>
	
		<!--- Get Updates --->
	<cffunction name="getUpdates" access="public" hint="returns the content of a user's Updates tab">
		<cfargument name="begin_timestamp" type="date" />
		<cfargument name="params" 			type="any" />
		<cfset begin_timestamp = DateDiff("s", CreateDate(2011,5,1),  '#arguments.begin_timestamp#') />
		<cfset end_timestamp = dateDiff("s", CreateDate(2011,5,1), now())>
		<cfscript>
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='get_updates',
									begin_timestamp = '#begin_timestamp#', end_timestamp = '#end_timestamp#', params = '#arguments.params#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getUpdates">
		<cfreturn getUpdates>
	</cffunction>
	
		<!--- To find ID from the Path --->
	<cffunction name="pathtoId" access="public" output="false" >
		<cfargument name="path" type="any" required="true" 	hint="path value" />
		<cfargument name="type" type="any" required="false" default="" />
		<cfset xPathSyn = "/response/tree/folder[@id=0]">
		<cfif listLen(arguments.path,'/') neq 0>
		<cfset i = 1>
			<cfloop list="#arguments.path#" delimiters="/" index="folderName">
			<cfif i eq listLen(arguments.path,'/') and arguments.type eq "file">
				<cfset xPathSyn = xPathSyn & "/files/file[@file_name='#folderName#']">
			<cfelse>
				<cfoutput>#folderName#</cfoutput><br>
				<cfset xPathSyn = xPathSyn & "/folders/folder[@name='#folderName#']"> 
			</cfif>
				<cfset i = i+1>
			</cfloop>
		</cfif>
		<cfscript>
				var req = getBoxTree();
				req = xmlParse(req.Filecontent,false);
				xPathSyn = xPathSyn & "/@id/";
				target = xmlSearch(req,"#xPathSyn#");
					if (arrayIsEmpty(target))
					{
						writeOutput('File or folder not found, Path In correct' ); abort;
					}
					else
					{
						return target[1].XmlValue;
					}
		</cfscript>	
	</cffunction>
	
		<!---buildParamString(arguments)--->
	<cffunction name="buildParamString" access="public" output="false" returntype="String" hint="I loop through a struct to convert to query params for the URL">
		<cfargument name="argScope" required="true" type="struct" hint="I am the struct containing the method params" />
			<cfset var strURLParam 	= '' />
			<cfloop collection="#arguments.argScope#" item="key">
				<cfif len(arguments.argScope[key])>
				<cfif listLen(strURLParam)>
					<cfset strURLParam = strURLParam & '&' />
				</cfif>	
					<cfset strURLParam = strURLParam & lcase(key) & '=' & arguments.argScope[key] />
				</cfif>
			</cfloop>
		<cfreturn strURLParam />
	</cffunction>
	
	

		<!--- Following are In Progress, to be completed --->
		
	<!--- To Private Share File or Folder--->
	<cffunction name="privateShare" access="public" description="To Private Share File or Folder">
		<cfargument name="target" 		type="any" hint="Folder or file to share private" />
		<cfargument name="path_from" 	type="any" hint="Path of folder or file to share" />
		<cfargument name="notify" 		type="any" hint="Notification to Send email" />
		<cfargument name="message" 		type="any" hint="A message to be included in a notification email" />
		<cfargument name="emails" 		type="any" hint="An array of emails for which to notify users about the newly shared file or folder" />
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type : '#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='private_share',
									target = '#arguments.target#', target_id = '#reqtarg#', notify = '#arguments.notify#',
									message = '#arguments.message#', emails='#arguments.emails#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="privateShare">
		<cfreturn privateShare />
	</cffunction>
	
		<!--- Request Friends --->
	<cffunction name="requestFriends" access="public" description="reqs new friends to be added to the user's network">
		<cfargument name="message" 	type="any" hint="A message to be included in a notification email" />
		<cfargument name="emails" 	type="any" hint="An array of emails for which to notify users about the newly shared file or folder" />
		<cfargument name="params" 	type="any" hint="To set additional, optional parameters" />
		<cfscript>
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='request_friends',
									message = '#arguments.message#', emails='#arguments.emails#', params = '#arguments.params#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="reqFriends">
		<cfreturn reqFriends />
	</cffunction>
	
		<!--- Get Versions --->
	<cffunction name="getVersions" access="public" description="To get Version of file">
		<cfargument name="path_from" type="any" hint="Get Version of file's path">
		<cfargument name="target" type="any" hint="Target folder or file">
		<cfscript>
			var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='get_versions',
									target_id = '#reqtarg#', target = '#arguments.target#'};
		</cfscript>
		<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="getVersions">
		<cfreturn getVersions />
	</cffunction>
	
		<!--- Make Current Version --->
	<cffunction name="currentVersions" access="public" description="To make Version of file">
		<cfargument name="path_from" type="any" hint="Make Version of file's path">
		<cfargument name="target" type="any" default="file" hint="Target file">
		
		<cfscript>
			//var versionof = getVersions(path_from :'#arguments.path_from#', target='#arguments.target#');
			//versionof = xmlParse(versionof.Filecontent,false);
			//xPath = "";
			//targetid = xmlSearch(versionof,"#xPath#");
			//target_id = targetid[1].XmlText;
			//var reqtarg = pathtoId(path : '#arguments.path_from#',type='#arguments.target#');
			//var httpParameters = {api_key=getInstanceValue('api_key'), auth_token=getInstanceValue('auth_token'), action='make_current_version',version_id = '#target_id#'};
		</cfscript>
		<!---<cfhttp url="#getInstanceValue('apiURL')##buildParamString(httpParameters)#" method="get" result="currentVersions">--->
		<cfreturn currentVersions />
	</cffunction>
	
</cfcomponent>
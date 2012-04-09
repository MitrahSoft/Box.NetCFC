<cfcomponent displayname="Application" output="true" >
	<cfscript>
		this.name = 'Box';
		this.sessionManagement = true;
		this.ApplicationTimeout = CreateTimeSpan( 0, 0, 1, 0 );
	</cfscript>

	<cffunction name="OnApplicationStart" access="public" returntype="boolean"  >
		<cfscript>
			application.objBox = createObject('component','Box')
			.init (
					ticket = ''	,
					auth_token = '',
					api_key = '',
					email = ''
				);
			return true;
		</cfscript>
	</cffunction>
	
	<cffunction name="onrequestStart">
		<cfscript>
		if(structKeyExists(url, 'reinit')) {
			onApplicationStart();
		}
		</cfscript>
	</cffunction>	
	
</cfcomponent>
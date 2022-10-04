# Managing Images
To configure registries for the podman command, you need to update the /etc/containers/registries.conf file. 
Edit the registries entry in the [registries.search] section, adding an entry to the values list:
```[registries.search]
registries = ["registry.access.redhat.com", "quay.io"]
```

Secure connections to a registry require a trusted certificate. To support insecure connections, 
add the registry name to the registries entry in [registries.insecure] section of /etc/containers/registries.conf file:
```[registries.insecure]
registries = ['localhost:5000']
```

To list all repositories available in a registry, use the /v2/_catalog endpoint. The n parameter is used to limit the number of repositories to return:
```[user@host ~]$ curl -Ls https://myserver/v2/_catalog?n=3
{"repositories":["centos/httpd","do180/custom-httpd","hello-openshift"]}'

The /v2/<name>/tags/list endpoint provides the list of tags available for a single image:
'[user@host ~]$ curl -Ls \
> https://quay.io/v2/redhattraining/httpd-parent/tags/list \
> | python -m json.tool
{
    "name": "redhattraining/httpd-parent",
    "tags": [
        "latest",
        "2.4"
    ]
}
```

Registry Authentication
Some container image registries require access authorization. The podman login command allows username and password authentication to a registry:
  
```[user@host ~]$ podman login -u username \
> -p password registry.access.redhat.com
Login Succeeded!```
  
The registry HTTP API requires authentication credentials. First, use the Red Hat Single Sign On (SSO) service to obtain an access token:
```[user@host ~]$ curl -u username:password -Ls \
> "https://sso.redhat.com/auth/realms/rhcc/protocol/redhat-docker-v2/auth?service=docker-registry"
{"token":"eyJh...o5G8",
"access_token":"eyJh...mgL4",
"expires_in":...output omitted...}[user@host ~]$
```
 
Then, include this token in a Bearer authorization header in subsequent requests:
```[user@host ~]$ curl -H "Authorization: Bearer eyJh...mgL4" \
>  -Ls https://registry.redhat.io/v2/rhel8/mysql-80/tags/list \
>  | python -mjson.tool
{
  "name": "rhel8/mysql-80",
    "tags": [
      "1.0",
      "1.2",
...output omitted...
```

Pulling Images
To pull container images from a registry, use the podman pull command:
```
[user@host ~]$ podman pull [OPTIONS] [REGISTRY[:PORT]/]NAME[:TAG]
[user@host ~]$ podman pull quay.io/bitnami/nginx
[user@host ~]$ podman images
[user@host ~]$ podman pull registry.redhat.io/rhel8/mysql-80:1
[user@host ~]$ podman run registry.redhat.io/rhel8/mysql-80:1
 ``` 



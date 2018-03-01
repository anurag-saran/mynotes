# PrintEnv

Example Node.js application that simply returns the process environment as a JSON object. Use jq to view the output.

E.g.
curl printenv:8080 | jq -S

opsworks-cookbooks
==================

Chef Cookbooks for the AWS OpsWorks Service used by Edools

## environment_variables

Set environment variables for your environment.

You can do 2 things:
* Sets environment variables for machine
	* To make it work specify your variables, enable Custom Chef Recipes and include "environment_variables::configure" recipe to the "configure" section of your application layer

To set environment variables specify custom Chef JSON with required key/value pairs.

E.g.
```json
{
  "environment_variables": {
    "NODE_ENV": "production"
  },
  "deploy": {
    "app_name": {
      "environment_variables": {
        "NODE_ENV": "production",
        "ENV_1": "value_of_env_1",
        "ENV_2": "value_of_env_2"
      }
    }
  }
}
```

In JSON above first "environment_variables" sets environment variables for machine (user root).
The section "environment_variables" under "deploy" specifying environment variables for Node.js process which will be hit with "monit restart app_name".

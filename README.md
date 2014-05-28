opsworks-cookbooks
==================

Chef Cookbooks for the AWS OpsWorks Service used by Edools

## environment_variables

Set environment variables for your environment.

To make it work enable Custom Chef Recipes:
- Repository type: `Git`
- Repository URL: `https://github.com/Edools/opsworks-cookbooks.git`

And include `environment_variables::default` recipe to the `deploy` section of your application layer.

To set environment variables specify custom Chef JSON with required 'key/value' pairs.

For example:
```json
{
  "environment_variables": {
    "VAR_1": "var-1-value",
    "VAR_2": "var-2-value"
  }
}
```

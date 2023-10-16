# DEPRECATED

Please use new [Testkube GH action](https://github.com/marketplace/actions/install-testkube) to build your pipeline more efficiently.

# Testkube Github action

This action executes Testkube command for resource with parameters and returns execution result.

## Inputs

## `command`

**Required** The command to be executed. Default `"get"`.

## `resource`

**Optional* The resource for the command. Default `"tests"`.

## `namespace`

**Optional* The namespace for the command. Default `"testkube"`.

## `api-key`

**Optional* The api key for the command. Default `""`.

## `api-uri`

**Optional* The api uri for the command. Default `""`.

## `parameters`

**Parameters** Additional command parameters. Default `""`.

## `stdin`

**Optional* The standard input for the command. Default `""`.

## Outputs

## `result`

The result of command execution.

## Example usage

```
uses: actions/testkube-docker-action@v1
with:
  command: 'get'
  resource: 'tests'
  namespace: 'testkube'
  parameters: '--crd-only'
```

All description of cli commands and thier arguments can be found at [https://kubeshop.github.io/testkube/reference/cli/testkube](https://kubeshop.github.io/testkube/reference/cli/testkube) 

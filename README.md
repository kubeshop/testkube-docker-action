# Testkube Docker Github action

This action executes Testkube command for resource with parameters and returns execution result.

## Inputs

## `command`

**Required** The command to be executed. Default `"get"`.

## `resource`

**Optional* The resource for the command. Default `"tests"`.

## `parameters`

**Parameters** Additional command parameters. Default `""`.

## Outputs

## `result`

The result of command execution.

## Example usage

uses: actions/testkube-docker-action@v1
with:
  command: 'get'
  resource: 'tests'
  parameters: '--crd-only'
  
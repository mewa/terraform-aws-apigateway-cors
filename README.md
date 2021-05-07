# Terraform API Gateway CORS module

This module intends to reduce boilerplate required when setting up CORS for API Gateway resources.

# Examples

An example module usage, which allows `GET` and `POST` methods from any origin (`*`), accepting default headers (Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token):

```
module "example_cors" {
  source  = "mewa/apigateway-cors/aws"
  version = "2.0.1"

  api      = aws_api_gateway_rest_api.example.id
  resource = aws_api_gateway_resource.example.id

  methods = ["GET", "POST"]
}
```

### Restrict origin

If you want to customize the allowed origin simply set the `origin` variable to your desired value:

```
module "confirm_cors" {
  source  = "mewa/apigateway-cors/aws"
  version = "2.0.1"

  api      = aws_api_gateway_rest_api.example.id
  resource = aws_api_gateway_resource.example.id

  methods = [aws_api_gateway_method.method01.http_method, aws_api_gateway_method.method02.http_method]

  origin = "https://example.com"
}
```


### Custom headers
You can also add other permitted headers, which will be appended to the default headers:

```
module "confirm_cors" {
  source  = "mewa/apigateway-cors/aws"
  version = "2.0.1"

  api      = aws_api_gateway_rest_api.example.id
  resource = aws_api_gateway_resource.example.id

  methods = ["GET"]

  origin  = "https://example.com"
  headers = "X-Custom-Header"
}
```

Setting `discard_default_headers` variable to true will result in including only the headers defined in `headers` variable.

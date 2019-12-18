# PassKit v4 REST Quickstart

## Overview

This quickstart is designed to get developers up and running quickly inside the PassKit v4 environment using REST.
If you believe we have missed something or there are ways we can improve our documentation. Please feel free to create a feature request and add in your thoughts.

You can learn even more by reading our [official API documentation](https://docs.passkit.io/)

## Table of Contents

- [Url](#url)
- [Authentication](#authenticaiton)
- [Create Account](#create-account)
- [Get Your API Keys](#get-your-api-keys)
- [Build Your Own Token](#build-your-own-token)
- [Profile Request](#profile-request)
- [Next Steps](#next-steps)

## Helpers

All the api endpoints used in this quickstart can be found in this Postman Collection
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/d72de46405be48eb164b)

## URL

Our API is accessable at `https://api.pub1.passkit.io` over HTTPS

## Authentication

Requests are authenticated using a [JWT](https://auth0.com/learn/json-web-tokens) supplied in the Authorization header of all requests, excluding `signup` and `login`
Our tokens are built with the following claims.

`exp` - The time when the token expires
`iat` - The time the token was issued
`uid` - The Id of the user that created it

_tokens expire 60 minutes after being issued_

example:

```json
{
  "exp": 1576642948,
  "iat": 1576639348,
  "uid": your - id
}
```

## Create Account

Before you can make any requests against the PassKit REST API, you will need to create an account.

#### API Client

POST - `https://api.pub1.passkit.io/user/new`

```json
{
  "username": "quickstart-user",
  "password": "my-password",
  "companyName": "quickstar-companyt",
  "emailAddress": "quickstart@mail.com"
}
```

#### CURL

```sh
curl -XPOST -H "Content-type: application/json" -d '{
	"username":"quickstart-user",
	"password":"my-password",
	"companyName":"quickstar-companyt",
	"emailAddress":"quickstart@mail.com"
}' 'https://api.pub1.passkit.io/user/new'
```

A successful request will return a JWT. You can use this token for the rest of the requests in this quickstart.

#### Get Your API Keys

Now that you have your account, its time to get your api keys so you can build your own tokens for further requests.

_If the token you received from creating your account has expired, you can use the login endpoint below to generate a new one_

#### API Client

POST - `https://api.pub1.passkit.io/login`

**Body**

```json
{
  "username": "quickstart-user",
  "password": "my-password"
}
```

#### CURL

```
curl -XPOST -H "Content-type: application/json" -d '{
	"username":"quickstart-user",
	"password":"my-password",
}' 'https://api.pub1.passkit.io/login'
```

Hit this endpoint to get your api keys

#### API Client

GET - `https://api.pub1.passkit.io/pk/user/restCredentials`
**Header**

```json
Authorization: your-token-here
```

#### CURL

```sh
curl -XGET -H 'Authorization: your-token-here' -H "Content-type: application/json" 'https://api.pub1.passkit.io/pk/user/restCredentials'
```

A successful request will return your api key and secret. Make sure to store these in a safe place.

## Building your own token

To build your own tokens you can use this [fiddle](https://jsfiddle.net/pkosterman/5Lagqyj7/)

As a convenience to users, each successful authenticated request you make against the PassKit v4 REST API returns a refreshed token in the response headers. Look for the `X-Passkit-Token` in the response headers for this token.

## Profile Request

Once you have created a new token, lets use it to get your user profile

#### API Client

GET - `https://api.pub1.passkit.io/user/profile`
**Header**

```json
Authorization: your-token-here
```

#### CURL

```sh
curl -XGET -H 'Authorization: your-token-here' -H "Content-type: application/json" 'https://api.pub1.passkit.io/user/profile'
```

A successful request will return details about your user profile inside PassKit

## Next Steps

Now that you have your credentials in place, you can start creating cool things inside the PassKit ecosystem.
Here are some other help articles to get your started:

- [Membership Cards](link)

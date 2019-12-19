# PassKit v4 REST Quickstart

**This quckstart is for the PassKit v4 [platform](https://app.passkit.com). These commands do not work for the v2 & v3 API's.**

**If you are looking for the old v2-v3 documentation you can find it [here](https://dev.passkit.net/#introduction)**

**We highly recommend using the v4 platform for new projects as v2 and v3 are scheduled for depreciation**

## Overview

This quickstart is designed to get developers up and running quickly inside the PassKit v4 environment using REST.
If you believe we have missed something or there are ways we can improve our documentation. Please feel free to create a feature request and add in your thoughts.

You can learn even more by reading our [official API documentation](https://docs.passkit.io/)

## Who is this for?

This qucikstart is a great place to start If you are looking to just get your feet wet inside the PassKit v4 environment, or if you are looking to implement a simple proof of concept integration with your existing system.

## Table of Contents

- [Url](#url)
- [Authentication](#authentication)
- [Create Account](#create-account)
- [Get Your API Keys](#get-your-api-keys)
- [Build Your Own Token](#build-your-own-token)
- [Profile Request](#profile-request)
- [Next Steps](#next-steps)

## Helpers

All the api endpoints used in this quickstart can be found in this Postman Collection

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/d72de46405be48eb164b)

You can also find them inside the [curl](./curl) folder in this repo

## URL

Our API is accessible at `https://api.pub1.passkit.io` over HTTPS

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
  "uid": "your-key"
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

```sh
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

- [Membership Program Enrollment](https://github.com/PassKit/passkit-rest-members-quickstart)

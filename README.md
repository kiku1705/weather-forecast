# Weather Forecast

Weather forecast is a web application made in ruby on rails to see weather forecast of a specific location based on provided address.

- Ruby version - 2.7
- Rails version - 6.0.6.1
- Redis

## Scope

Requirements:
- Must be done in Ruby on Rails
- Accept an address as input
- Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)
- Display the requested forecast details to the user
- Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
- Display indicator if result is pulled from cache.

## Installation
```
git clone git@github.com:kiku1705/weather-forecast.git
cd weather_forecast
```
Use the `bundle install` command to install project dependencies.

```bash
bundle install
```

## Configuring third party API's 
`Geocoder` and `Openweathermap` Third party API's are used in this application
- Geocoder : To get latitude and longitude for the input address
- Openweathermap - To get the current forecast data

For Geocoder we are using default lookup service `nominatim` but one can configure multiple api's, please see [API Guide for Geocoder ](https://github.com/alexreisner/geocoder/blob/master/README_API_GUIDE.md)

To work with Openweathermap, please create an account [here](https://openweathermap.org/api) and get an API KEY and set ENV variable `OPEN_WEATHER_MAP_API_KEY`

## Setup the application locally
1. create a settings.yml and add env variables as per enviornments, sample
 ```
development:
  REDIS_DB_DEV: 0
  REDIS_URL: <REDIS_DEVELOPMENT_URL>

testing:
  REDIS_DB_TEST: 1
  REDIS_URL: <REDIS_TEST_URL>

production:
  REDIS_DB_PROD: 2
  REDIS_URL: <REDIS_PRODUCTION_URL>
```
2. start redis server using `redis-server`
3. create database using `rails db:create`
4. start the rails application `rails s`

## Application flow
* visit [localhost:3000/](http://localhost:3000/) enter the address and hit lookup
* if address is correct, it will show current forecast result
* application supports caching as well and if weather data is retrieved from cache it will show the temprature in green text

* In case of failure you will see appropriate message

## Running test cases
To run test cases please run `bundle exec rspec spec`

## Demo screens of the application

![alt text](https://private-user-images.githubusercontent.com/6051977/395947917-196e716c-a3c6-47a3-bfff-17fc452cae9e.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzQzMTk2MjUsIm5iZiI6MTczNDMxOTMyNSwicGF0aCI6Ii82MDUxOTc3LzM5NTk0NzkxNy0xOTZlNzE2Yy1hM2M2LTQ3YTMtYmZmZi0xN2ZjNDUyY2FlOWUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI0MTIxNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNDEyMTZUMDMyMjA1WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9NjQxZWI0NDA2Nzk3OGJlNzVmNjZjMWQzMzljOTNmNTA3MjYyZDg0MjBmMGVlZDkwZWMxNDY5ODQwOTc3N2RiMSZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.JY3luAyiqV89x3LFCKkzl21oVceqBImNw6Wr2RwPGug)

![alt text](https://private-user-images.githubusercontent.com/6051977/395947927-fa7c5672-15fd-479a-af0c-a60ff31d80dd.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzQzMTk2MjUsIm5iZiI6MTczNDMxOTMyNSwicGF0aCI6Ii82MDUxOTc3LzM5NTk0NzkyNy1mYTdjNTY3Mi0xNWZkLTQ3OWEtYWYwYy1hNjBmZjMxZDgwZGQucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI0MTIxNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNDEyMTZUMDMyMjA1WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YmFiNjllMmY2OGRlYmE0OTJiMzliZjdhMTBlNmRmNzAzZjk4NjBlNTdiNmVmNmM1MmZkMjNiZjY2NDljMGU3MiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ._iB1Qg1fxiDpaK0efed0wjUzdvHhPthM6r2xNmz0meo)




# ![Aha! Funnel Report](/app/assets/images/example-report.png?raw=true)

# Aha! Funnel Report

This is a small Rails application that creates a funnel report of ideas from your Aha! account. 

The app is intended to address idea [APP-I-3533](https://big.ideas.aha.io/ideas/APP-I-3533) from the Aha! website.

Oauth2 is used to allow the app to access data within an Aha! account via the Aha! API.

For privacy, no Aha! user data is ever persisted.

## Demo
A working live demo hosted on AWS can be found here: [https://vierless.com/aha/](https://vierless.com/aha/)

## Built with 

- Rails
- Aha! API
- Oauth2
- Bootstrap
- JQuery
- Google Charts


## Testing

Testing is implemented via RSpec and Capybara including:
- model tests
- controller tests
- view tests
- feature tests
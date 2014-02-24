# howto.email

## Installation

### Dependencies

Install system dependencies:

 - Heroku Toolbelt
 - PostgreSQL
 - Ruby 2.1.1

and install gems:

```bash
bundle install
```

### Repository configuration

Add the deployment remote:

```bash
heroku git:remote -a howto-email
```

### Database configuration

Create a PostgreSQL user that has permission to create databases,

```sql
create user xxxxxxxx with password 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
alter user xxxxxxxx createdb;
```

add its credentials to `.env`,

```bash
DB_USERNAME='xxxxxxxx'
DB_PASSWORD='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
```

and then initialize the databases:

```bash
foreman run rake db:setup
foreman run rake db:migrate
```

## Usage

### Development server

Start the server in development mode:

```bash
foreman start
```

### Testing

Run all tests:

```bash
foreman run rake test
```

### Deployment

#### Push to Heroku

Push commits to Heroku:

```bash
rake deploy
```

Confirm success by reviewing the application logs:

```bash
heroku logs
```

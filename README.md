# README

* Ruby version: 2.0.0

* Database creation: 

```bash
rake db:create && db:migrate
```

* Seeding Data:

```bash
YEAR=2015 rake calendar:add_year
rake db:seed
```

* How to run the test suite: 

```bash
rspec
```

Or watch for changes:

```bash
guard
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions:

  * Should add a job that adds new calendar dates yearly (`rake calendar:add_year YEAR=2015`)

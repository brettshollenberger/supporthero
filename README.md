# README

* Ruby version: 2.0.0

* Database creation: 

```bash
rake db:create && db:migrate
```

* Seeding Data:

```bash
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

  * Run with Godfile to monitor the Unicorn master process

```bash
god -c ./supporthero.god
```

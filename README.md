# Habits

Tracking habits at the command line using SQLite and bash.

## How to set it up

Right now, I'm only tracking my weight and whether I've taken my medicine. But if you want to add things, you need to adjust the [SCHEMA.sql](/SCHEMA.sql) file and the [run.sh](/run.sh) file. It would be nice to turn this into more configurable parts/components, but I only have two habits to track right now. When I add a third, I'll add an abstraction layer.

Once you've set it up, create the database with the following command:

```sh 
sqlite3 habits.db ".read SCHEMA.sql"
```

## How to use it

```sh
./run.sh
```

## Testing

We're going to use [shunit2](https://github.com/kward/shunit2) to test. Let's see how this goes...


```sh
./tests/runtests.sh
```

## Why?

I dunno, I like the simplicity of it and it gives me an opportunity to play with SQLite and Bash.

## License

Public Domain (or [Blue Oak Model License 1.0.0](https://blueoakcouncil.org/license/1.0.0) for those who need a license)
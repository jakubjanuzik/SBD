from flask.ext.script import Command
import psycopg2


class CreateDB(Command):
    "Creates a DB"

    def run(self):
        print("hello world")
        # TO be filled with creation script

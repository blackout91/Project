require_relative 'main.rb'

desc "Default execution sequence"
task :default => :run do
end

desc "Deletes pre-existing database"
task :deleteolddb do
    puts "Deleting old database"
    File.delete("public/db")
end

desc "Creates fresh database"
task :db => :deleteolddb do
    puts "Creating new database"
    @db = SQLite3::Database.new './public/db'
end

desc "Loads schema into database"
task :loadschema => :db do
    puts "Loading schema"
    @db.execute('
        CREATE TABLE users(
            userID INTEGER NOT NULL PRIMARY KEY,
            firstname TEXT,
            lastname TEXT,
            address TEXT,
            email TEXT,
            homephone INTEGER,
            mobphone INTEGER,
            handle TEXT,
            permission TEXT,
            password TEXT,
            city TEXT,
            offers INTEGER
        );
    ')

    @db.execute('
        CREATE TABLE menu(
            itemID INTEGER NOT NULL PRIMARY KEY,
            item TEXT,
            size TEXT,
            price FLOAT,
            city TEXT
        );
    ')

    @db.execute('
        CREATE TABLE orders(
            orderID INTEGER NOT NULL REFERENCES orderdetails(orderID),
            time INTEGER,
            userID INTEGER NOT NULL REFERENCES users(userID),
            totalprice INTEGER,
            completion TEXT,
            month INTEGER,
            city TEXT
        );
    ')

    @db.execute('
        CREATE TABLE orderdetails(
            orderID INTEGER NOT NULL,
            itemID INTEGER NOT NULL REFERENCES menu(itemID),
            tweetID INTEGER NOT NULL
        );
    ')

    @db.execute('
        CREATE TABLE basket(
            basketIndex INTEGER NOT NULL,
            itemID INTEGER NOT NULL REFERENCES menu(itemID),
            price INTEGER NOT NULL REFERENCES menu(price)
        );
    ')

    @db.execute('
        CREATE TABLE offers(
            offerID INTEGER NOT NULL,
            description TEXT,
            multiplier REAL
        );
    ')
end

desc "Loading default users"
task :loadusers => :loadschema do
    puts "Loading users"
    @db.execute('
        INSERT INTO users VALUES (0, "admin_first", "admin_last", "admin_post", "admin@admin.com", 123, 987, "admin", "admin", "nimda", "sheffield", 0);
    ')
    @db.execute('
        INSERT INTO users VALUES (1, "employee_first", "employee_last", "employee_post", "employee@employee.com", 456, 654, "employee", "employee", "eeyolpme", "leeds", 0);
    ')
    @db.execute('
        INSERT INTO users VALUES (2, "user_first", "user_last", "user_post", "user@user.com", 789, 321, "user", "user", "resu", "leeds", 0);
    ')
    @db.execute('
        INSERT INTO users VALUES (3, "Rokas", "Bagdonas", "user_post", "user@user.com", 789, 321, "@Rokasas5", "user", "resu", "leeds", 0);
    ')
    @db.execute('
        INSERT INTO users VALUES (4, "Bryn", "Berkeley", "user_post", "user@user.com", 789, 321, "@BrynBerkeley", "user", "resu", "sheffield", 0);
    ')
end

desc "Loading default menu"
task :loadmenu => :loadusers do
    puts "Loading default menu for Leeds"
    @db.execute('
        INSERT INTO menu VALUES (0, "Lamb Hotpot", "Large", 5.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (1, "Lamb Hotpot", "Medium", 4.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (2, "Lamb Hotpot", "Small", 3.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (3, "Pork Pie", "Large", 5.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (4, "Pork Pie", "Medium", 4.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (5, "Pork Pie", "Small", 3.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (6, "Veggie Pie", "Large", 5.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (7, "Veggie Pie", "Medium", 4.99, "leeds");
    ')
    @db.execute('
        INSERT INTO menu VALUES (8, "Veggie Pie", "Small", 3.99, "leeds");
    ')

    puts "Loading default menu for Sheffield"
    @db.execute('
        INSERT INTO menu VALUES (9, "Pork Pie", "Large", 5.99, "sheffield");
    ')
    @db.execute('
        INSERT INTO menu VALUES (10, "Pork Pie", "Medium", 4.99, "sheffield");
    ')
    @db.execute('
        INSERT INTO menu VALUES (11, "Pork Pie", "Small", 3.99, "sheffield");
    ')
    @db.execute('
        INSERT INTO menu VALUES (12, "Veggie Pie", "Large", 5.99, "sheffield");
    ')
    @db.execute('
        INSERT INTO menu VALUES (13, "Veggie Pie", "Medium", 4.99, "sheffield");
    ')
    @db.execute('
        INSERT INTO menu VALUES (14, "Veggie Pie", "Small", 3.99, "sheffield");
    ')
end

desc "Loading default offers"
task :loadoffers => :loadmenu do
    puts "Loading default offers"
    @db.execute('
        INSERT INTO offers VALUES (0, "No offers yet.", 1.0);
    ')
    @db.execute('
        INSERT INTO offers VALUES (1, "10% off!", 0.9);
    ')
    @db.execute('
        INSERT INTO offers VALUES (2, "20% off!", 0.8);
    ')
    @db.execute('
        INSERT INTO offers VALUES (3, "30% off!", 0.7);
    ')
    @db.execute('
        INSERT INTO offers VALUES (4, "40% off!", 0.6);
    ')
    @db.execute('
        INSERT INTO offers VALUES (5, "50% off!", 0.5);
    ')
    @db.execute('
        INSERT INTO offers VALUES (6, "60% off!", 0.4);
    ')
    @db.execute('
        INSERT INTO offers VALUES (7, "70% off!", 0.3);
    ')
     @db.execute('
        INSERT INTO offers VALUES (8, "80% off!", 0.2);
    ')
    @db.execute('
        INSERT INTO offers VALUES (9, "90% off!", 0.1);
    ')
end

desc "Run application locally"
task :run => :loadoffers do
    puts "Launching app"
    Sinatra::Application.run!
end
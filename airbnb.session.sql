CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(2)
);

-- @BLOCK
INSERT INTO Users (email, bio, country)
VALUES
    ('hola@munda.com', 'bar', 'MX'),
    ('bonjour@monde.com', 'baz', 'FR');

-- @BLOCK
SELECT email, id FROM Users

WHERE country = 'US'
AND id > 1
OR email LIKE 'h%'

ORDER BY id ASC
LIMIT 2;

-- @BLOCK
CREATE INDEX email_index ON Users(email);
-- now when making a query for emails it will be faster

-- @BLOCK
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(owner_id) REFERENCES Users(id)
);

-- @BLOCK
INSERT INTO Rooms (street, owner_id)
VALUES
    ('san diego sailboat', 1),
    ('nantucket cottage', 1),
    ('vail cabin', 1),
    ('sf cardboard box', 1);

-- @BLOCK
SELECT * FROM Users
INNER JOIN Rooms
ON Rooms.owner_id = Users.id
-- queries all user room pairings

-- @BLOCK
SELECT * FROM Users
LEFT JOIN Rooms
ON Rooms.owner_id = Users.id
-- queries all users and corresponding rooms if existing

-- @BLOCK
SELECT * FROM Users
RIGHT JOIN Rooms
ON Rooms.owner_id = Users.id
-- queries all rooms and corresponding users if existing

-- @BLOCK
SELECT
    Users.id AS user_id,
    Rooms.id AS room_id,
    email,
    street
FROM Users
INNER JOIN Rooms
ON Rooms.owner_id = Users.id
-- display fields under different names

-- @BLOCK
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME,
    PRIMARY KEY(id),
    FOREIGN KEY(guest_id) REFERENCES Users(id),
    FOREIGN KEY(room_id) REFERENCES Rooms(id)
);

-- @BLOCK
INSERT INTO Bookings (guest_id, room_id, check_in)
VALUES
    (1, 2, '2019-01-01 12:00:00'),
    (2, 2, '2019-01-10 12:00:00'),
    (3, 1, '2019-01-01 12:00:00');


-- @BLOCK
SELECT
    guest_id,
    street,
    check_in 
FROM Bookings
INNER JOIN Rooms ON Rooms.owner_id = guest_id;

-- @BLOCK Rooms a user has booked
SELECT
    guest_id,
    street,
    check_in
FROM Bookings
INNER JOIN Rooms ON Rooms.owner_id = guest_id
WHERE guest_id = 1;
-- get all the bookings the guest has and join the corresponding rooms based on rooms owner_id

-- @BLOCK Guests who stayed in a room
SELECT
    room_id,
    guest_id,
    email,
    bio
FROM Bookings
INNER JOIN Users on Users.id = guest_id
WHERE room_id = 2;
-- get all the bookings of the room and join the corresponding users
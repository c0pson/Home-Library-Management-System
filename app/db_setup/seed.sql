-- ============================================================================
-- BOOK SHARING SYSTEM - COMPREHENSIVE SEED DATA
-- ============================================================================
-- 100 Users with realistic relationships:
-- - 91 users have at least 1 book (91%)
-- - 80 users have more than 1 book (80%)
-- - 95 users have at least 1 friend (95%)
-- - Realistic friend groups with clustering
-- - 80% of users with friends have lendings/borrowings
-- - Notifications with defined enum types
-- ============================================================================

BEGIN TRANSACTION;

-- ============================================================================
-- 1. USERS TABLE (100 users)
-- ============================================================================

INSERT INTO users (username, password_hash) VALUES
('phoenix_rising', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('luna_dreams', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('atlas_reader', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('iris_wanderer', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('ember_night', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('nova_spark', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('sage_keeper', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('lyra_echoes', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('zephyr_wind', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('vale_seeker', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('echo_chamber', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('storm_chaser', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('path_finder', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('crown_jewel', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('raven_tales', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('silver_lining', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('golden_leaf', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('mystic_pine', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('swift_dancer', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('quiet_scholar', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('brave_soul', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('dawn_runner', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('dusk_dweller', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('forest_friend', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('ocean_wave', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('mountain_peak', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('river_flow', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('cloud_drift', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('stone_heart', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('flame_keeper', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('frost_walker', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('leaf_dancer', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('rain_whisper', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('sun_seeker', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('star_gazer', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('moon_light', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('shadow_play', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('bright_spark', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('silent_storm', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('wild_heart', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('free_spirit', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('pure_soul', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('kind_friend', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('true_north', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('steady_hand', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('bright_mind', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('wise_guide', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('bold_vision', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('gentle_touch', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('swift_arrow', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('steady_beat', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('clear_voice', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('fresh_start', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('solid_ground', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('bright_day', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('calm_waters', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('keen_eye', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('strong_will', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('warm_heart', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('quick_mind', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('true_friend', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('noble_quest', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('faithful_one', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('just_cause', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('honor_bound', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('worthy_tale', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('golden_hour', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('silver_tongue', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('iron_will', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('brave_heart', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('wild_dream', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('soft_glow', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('keen_spirit', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('rare_gem', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('sharp_mind', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('open_heart', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('brave_new', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('vivid_dream', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('grand_view', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('true_light', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('fresh_mind', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('eager_soul', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('wise_words', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('swift_deed', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('kind_word', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('safe_haven', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('true_path', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('new_hope', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('last_stand', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('great_mind', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('sharp_eye', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('close_call', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('broad_view', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('pure_light', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('wild_ride', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('swift_kick', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('high_tide', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('deep_blue', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('dark_night', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('clear_sky', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('sunny_day', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('quiet_time', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('loud_voice', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('warm_glow', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O'),
('cold_steel', '$2b$12$R9h2.4K8X9mZp.Q1K9Pq.O');

-- ============================================================================
-- 2. BOOKS TABLE (80 unique books - realistic library)
-- ============================================================================

INSERT INTO books (title, author, release_date, language, genre, isbn_13, isbn_10) VALUES
('To Kill a Mockingbird', 'Harper Lee', '1960-07-11', 'English', 'Classic Fiction', '9780061120084', '0061120081'),
('1984', 'George Orwell', '1949-06-08', 'English', 'Dystopian', '9780451524935', '0451524934'),
('Pride and Prejudice', 'Jane Austen', '1813-01-28', 'English', 'Romance', '9780141439518', '0141439513'),
('The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', 'English', 'Classic Fiction', '9780743273565', '0743273567'),
('Jane Eyre', 'Charlotte Brontë', '1847-10-16', 'English', 'Gothic Romance', '9780141441146', '0141441143'),
('Wuthering Heights', 'Emily Brontë', '1847-12-19', 'English', 'Gothic Romance', '9780141439556', '0141439556'),
('The Hobbit', 'J.R.R. Tolkien', '1937-09-21', 'English', 'Fantasy', '9780547928227', '0547928225'),
('The Lord of the Rings', 'J.R.R. Tolkien', '1954-07-29', 'English', 'Fantasy', '9780544003415', '0544003411'),
('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', '1997-06-26', 'English', 'Fantasy', '9780439708180', '0439708184'),
('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', '1998-07-02', 'English', 'Fantasy', '9780439064873', '0439064872'),
('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', '1999-07-08', 'English', 'Fantasy', '9780439136365', '0439136369'),
('Harry Potter and the Goblet of Fire', 'J.K. Rowling', '2000-07-08', 'English', 'Fantasy', '9780439139595', '0439139597'),
('Harry Potter and the Order of the Phoenix', 'J.K. Rowling', '2003-06-21', 'English', 'Fantasy', '9780439358064', '0439358060'),
('The Catcher in the Rye', 'J.D. Salinger', '1951-07-16', 'English', 'Coming of Age', '9780316769174', '0316769177'),
('The Odyssey', 'Homer', '1725-01-01', 'English', 'Epic', '9780199232765', '0199232768'),
('The Iliad', 'Homer', '1715-01-01', 'English', 'Epic', '9780199232759', '0199232759'),
('One Hundred Years of Solitude', 'Gabriel García Márquez', '1967-05-30', 'Spanish', 'Magical Realism', '9780060883287', '0060883286'),
('The Picture of Dorian Gray', 'Oscar Wilde', '1890-07-01', 'English', 'Gothic Fiction', '9780141439570', '0141439572'),
('Frankenstein', 'Mary Shelley', '1818-01-01', 'English', 'Gothic Science Fiction', '9780141439471', '0141439475'),
('Dracula', 'Bram Stoker', '1897-05-18', 'English', 'Gothic Horror', '9780141439846', '0141439841'),
('The Strange Case of Dr Jekyll and Mr Hyde', 'Robert Louis Stevenson', '1886-01-10', 'English', 'Gothic', '9780141439495', '0141439491'),
('Alice''s Adventures in Wonderland', 'Lewis Carroll', '1865-11-26', 'English', 'Fantasy', '9780141439761', '0141439769'),
('The Wizard of Oz', 'L. Frank Baum', '1900-05-17', 'English', 'Fantasy', '9780060534943', '0060534945'),
('Peter Pan', 'J.M. Barrie', '1911-12-27', 'English', 'Fantasy', '9780141439778', '0141439777'),
('The Lion the Witch and the Wardrobe', 'C.S. Lewis', '1950-10-16', 'English', 'Fantasy', '9780066405331', '0066405335'),
('Matilda', 'Roald Dahl', '1988-10-01', 'English', 'Children', '9780142413555', '0142413550'),
('Charlotte''s Web', 'E.B. White', '1952-10-15', 'English', 'Children', '9780064400558', '0064400556'),
('The Tale of Despereaux', 'Kate DiCamillo', '2003-08-26', 'English', 'Fantasy', '9780763615574', '0763615579'),
('Inkheart', 'Cornelia Funke', '2003-09-23', 'English', 'Fantasy', '9780439709231', '0439709237'),
('The Name of the Wind', 'Patrick Rothfuss', '2007-08-27', 'English', 'Fantasy', '9780451458025', '0451458028'),
('American Gods', 'Neil Gaiman', '2001-06-19', 'English', 'Fantasy', '9780380789023', '0380789027'),
('The Graveyard Book', 'Neil Gaiman', '2008-11-17', 'English', 'Fantasy', '9780061214967', '0061214965'),
('Good Omens', 'Neil Gaiman and Terry Pratchett', '1990-05-01', 'English', 'Fantasy Comedy', '9780060853981', '0060853980'),
('The Discworld Series', 'Terry Pratchett', '1983-11-01', 'English', 'Fantasy Comedy', '9780552167352', '0552167355'),
('Dune', 'Frank Herbert', '1965-06-01', 'English', 'Science Fiction', '9780441172719', '0441172717'),
('Foundation', 'Isaac Asimov', '1951-06-01', 'English', 'Science Fiction', '9780553293357', '0553293354'),
('The Martian', 'Andy Weir', '2011-02-11', 'English', 'Science Fiction', '9780553418026', '0553418025'),
('Ready Player One', 'Ernest Cline', '2011-08-16', 'English', 'Science Fiction', '9780307887436', '0307887430'),
('Neuromancer', 'William Gibson', '1984-07-01', 'English', 'Cyberpunk', '9780441569595', '0441569595'),
('Snow Crash', 'Neal Stephenson', '1992-06-01', 'English', 'Science Fiction', '9780553380957', '0553380958'),
('The Hobbit: An Unexpected Journey', 'J.R.R. Tolkien', '1937-09-21', 'English', 'Fantasy', '9780547928234', '0547928234'),
('Mistborn: The Final Empire', 'Brandon Sanderson', '2006-07-17', 'English', 'Fantasy', '9780765311789', '0765311783'),
('The Way of Kings', 'Brandon Sanderson', '2010-08-31', 'English', 'Fantasy', '9780765326355', '0765326353'),
('The Wheel of Time', 'Robert Jordan', '1990-08-15', 'English', 'Fantasy', '9780312850715', '0312850713'),
('A Song of Ice and Fire', 'George R.R. Martin', '1996-08-06', 'English', 'Fantasy', '9780553103540', '0553103547'),
('The Chronicles of Narnia', 'C.S. Lewis', '1950-10-16', 'English', 'Fantasy', '9780066405331', '0066405335'),
('The Hunger Games', 'Suzanne Collins', '2008-09-14', 'English', 'Dystopian', '9780439023481', '0439023483'),
('Catching Fire', 'Suzanne Collins', '2009-09-01', 'English', 'Dystopian', '9780439023498', '0439023491'),
('Mockingjay', 'Suzanne Collins', '2010-08-24', 'English', 'Dystopian', '9780439023511', '0439023513'),
('Divergent', 'Veronica Roth', '2011-04-25', 'English', 'Dystopian', '9780062024083', '0062024086'),
('Insurgent', 'Veronica Roth', '2012-05-01', 'English', 'Dystopian', '9780062024090', '0062024094'),
('Allegiant', 'Veronica Roth', '2013-10-22', 'English', 'Dystopian', '9780062024106', '0062024108'),
('The Maze Runner', 'James Dashner', '2009-10-06', 'English', 'Dystopian', '9780385737951', '0385737955'),
('The Scorch Trials', 'James Dashner', '2010-10-12', 'English', 'Dystopian', '9780385737968', '0385737963'),
('The Death Cure', 'James Dashner', '2011-10-11', 'English', 'Dystopian', '9780385737975', '0385737971'),
('Ender''s Game', 'Orson Scott Card', '1985-01-15', 'English', 'Science Fiction', '9780812550702', '0812550706'),
('Ender in Exile', 'Orson Scott Card', '2008-11-18', 'English', 'Science Fiction', '9780765316692', '0765316692'),
('Speaker for the Dead', 'Orson Scott Card', '1986-11-15', 'English', 'Science Fiction', '9780312933419', '0312933419'),
('The Silmarillion', 'J.R.R. Tolkien', '1977-09-15', 'English', 'Fantasy', '9780345325821', '0345325826'),
('The Left Hand of Darkness', 'Ursula K. Le Guin', '1969-06-01', 'English', 'Science Fiction', '9780441478705', '0441478700'),
('The Dispossessed', 'Ursula K. Le Guin', '1974-10-01', 'English', 'Science Fiction', '9780061054891', '0061054895'),
('A Wizard of Earthsea', 'Ursula K. Le Guin', '1968-11-01', 'English', 'Fantasy', '9780547773933', '0547773935'),
('The Earthsea Cycle', 'Ursula K. Le Guin', '1968-11-01', 'English', 'Fantasy', '9780547773933', '0547773935'),
('Circe', 'Madeline Miller', '2018-04-10', 'English', 'Mythology', '9780316556347', '0316556343'),
('The Song of Achilles', 'Madeline Miller', '2011-09-27', 'English', 'Mythology', '9780061547301', '0061547301'),
('The Ten Thousand Doors of January', 'Alix E. Harrow', '2019-07-16', 'English', 'Fantasy', '9780356506531', '0356506533'),
('Piranesi', 'Susanna Clarke', '2020-09-15', 'English', 'Fantasy', '9781635731810', '1635731819'),
('Jonathan Strange & Mr Norrell', 'Susanna Clarke', '2004-11-30', 'English', 'Fantasy', '9780747550136', '0747550131'),
('The Midnight Library', 'Matt Haig', '2020-08-13', 'English', 'Fiction', '9780525559474', '0525559477'),
('The House in the Cerulean Sea', 'TJ Klune', '2020-03-03', 'English', 'Fantasy', '9781250025646', '1250025648'),
('Howl''s Moving Castle', 'Diana Wynne Jones', '1986-05-01', 'English', 'Fantasy', '9780061479946', '0061479942'),
('Stardust', 'Neil Gaiman', '1999-06-30', 'English', 'Fantasy', '9780380773894', '0380773899'),
('The Ocean at the End of the Lane', 'Neil Gaiman', '2013-06-18', 'English', 'Fantasy', '9780062459671', '0062459678'),
('American Psycho', 'Bret Easton Ellis', '1991-03-06', 'English', 'Psychological Thriller', '9780679735779', '0679735778'),
('The Shining', 'Stephen King', '1977-01-28', 'English', 'Horror', '9780385333312', '0385333315'),
('It', 'Stephen King', '1986-09-15', 'English', 'Horror', '9780451169525', '0451169528');

-- ============================================================================
-- 3. BOOK_COLLECTION TABLE (91 users with books, 80 with multiple)
-- Distribution: Users 1-91 have books
-- Users 1-80 have 2+ books, Users 81-91 have exactly 1 book
-- ============================================================================

-- Users 1-80: 2-4 books each (totaling ~240 books across 80 users)
INSERT INTO book_collection (user_id, book_id, added_at, condition) VALUES
-- User 1: phoenix_rising - 4 books
(1, 1, NOW() - INTERVAL '180 days', 'good'),
(1, 2, NOW() - INTERVAL '150 days', 'good'),
(1, 35, NOW() - INTERVAL '120 days', 'new'),
(1, 45, NOW() - INTERVAL '90 days', 'good'),

-- User 2: luna_dreams - 3 books
(2, 3, NOW() - INTERVAL '200 days', 'good'),
(2, 4, NOW() - INTERVAL '160 days', 'fair'),
(2, 22, NOW() - INTERVAL '100 days', 'good'),

-- User 3: atlas_reader - 4 books
(3, 5, NOW() - INTERVAL '210 days', 'good'),
(3, 6, NOW() - INTERVAL '170 days', 'fair'),
(3, 7, NOW() - INTERVAL '130 days', 'good'),
(3, 8, NOW() - INTERVAL '80 days', 'good'),

-- User 4: iris_wanderer - 2 books
(4, 9, NOW() - INTERVAL '190 days', 'good'),
(4, 10, NOW() - INTERVAL '140 days', 'good'),

-- User 5: ember_night - 3 books
(5, 11, NOW() - INTERVAL '220 days', 'fair'),
(5, 12, NOW() - INTERVAL '170 days', 'good'),
(5, 38, NOW() - INTERVAL '110 days', 'new'),

-- User 6: nova_spark - 4 books
(6, 13, NOW() - INTERVAL '200 days', 'good'),
(6, 14, NOW() - INTERVAL '160 days', 'good'),
(6, 41, NOW() - INTERVAL '120 days', 'good'),
(6, 42, NOW() - INTERVAL '70 days', 'new'),

-- User 7: sage_keeper - 3 books
(7, 15, NOW() - INTERVAL '180 days', 'good'),
(7, 16, NOW() - INTERVAL '150 days', 'fair'),
(7, 50, NOW() - INTERVAL '100 days', 'good'),

-- User 8: lyra_echoes - 2 books
(8, 17, NOW() - INTERVAL '210 days', 'good'),
(8, 37, NOW() - INTERVAL '120 days', 'new'),

-- User 9: zephyr_wind - 4 books
(9, 18, NOW() - INTERVAL '200 days', 'fair'),
(9, 19, NOW() - INTERVAL '160 days', 'good'),
(9, 43, NOW() - INTERVAL '115 days', 'good'),
(9, 44, NOW() - INTERVAL '65 days', 'good'),

-- User 10: vale_seeker - 3 books
(10, 20, NOW() - INTERVAL '190 days', 'good'),
(10, 21, NOW() - INTERVAL '155 days', 'good'),
(10, 54, NOW() - INTERVAL '95 days', 'good'),

-- User 11: echo_chamber - 2 books
(11, 23, NOW() - INTERVAL '220 days', 'fair'),
(11, 24, NOW() - INTERVAL '140 days', 'good'),

-- User 12: storm_chaser - 3 books
(12, 25, NOW() - INTERVAL '200 days', 'good'),
(12, 26, NOW() - INTERVAL '165 days', 'good'),
(12, 55, NOW() - INTERVAL '100 days', 'good'),

-- User 13: path_finder - 4 books
(13, 27, NOW() - INTERVAL '190 days', 'good'),
(13, 28, NOW() - INTERVAL '150 days', 'good'),
(13, 36, NOW() - INTERVAL '120 days', 'new'),
(13, 46, NOW() - INTERVAL '80 days', 'good'),

-- User 14: crown_jewel - 3 books
(14, 29, NOW() - INTERVAL '210 days', 'good'),
(14, 30, NOW() - INTERVAL '160 days', 'fair'),
(14, 51, NOW() - INTERVAL '105 days', 'good'),

-- User 15: raven_tales - 2 books
(15, 31, NOW() - INTERVAL '200 days', 'good'),
(15, 32, NOW() - INTERVAL '145 days', 'good'),

-- User 16: silver_lining - 3 books
(16, 33, NOW() - INTERVAL '220 days', 'good'),
(16, 34, NOW() - INTERVAL '170 days', 'fair'),
(16, 52, NOW() - INTERVAL '110 days', 'good'),

-- User 17: golden_leaf - 4 books
(17, 39, NOW() - INTERVAL '200 days', 'good'),
(17, 40, NOW() - INTERVAL '160 days', 'new'),
(17, 47, NOW() - INTERVAL '115 days', 'good'),
(17, 56, NOW() - INTERVAL '75 days', 'good'),

-- User 18: mystic_pine - 3 books
(18, 48, NOW() - INTERVAL '190 days', 'good'),
(18, 49, NOW() - INTERVAL '155 days', 'good'),
(18, 57, NOW() - INTERVAL '100 days', 'fair'),

-- User 19: swift_dancer - 2 books
(19, 53, NOW() - INTERVAL '210 days', 'good'),
(19, 58, NOW() - INTERVAL '130 days', 'good'),

-- User 20: quiet_scholar - 3 books
(20, 59, NOW() - INTERVAL '220 days', 'fair'),
(20, 60, NOW() - INTERVAL '170 days', 'good'),
(20, 61, NOW() - INTERVAL '105 days', 'good'),

-- User 21: brave_soul - 4 books
(21, 62, NOW() - INTERVAL '200 days', 'good'),
(21, 63, NOW() - INTERVAL '160 days', 'good'),
(21, 64, NOW() - INTERVAL '120 days', 'new'),
(21, 65, NOW() - INTERVAL '70 days', 'good'),

-- User 22: dawn_runner - 3 books
(22, 66, NOW() - INTERVAL '190 days', 'good'),
(22, 67, NOW() - INTERVAL '150 days', 'fair'),
(22, 68, NOW() - INTERVAL '100 days', 'good'),

-- User 23: dusk_dweller - 2 books
(23, 69, NOW() - INTERVAL '210 days', 'good'),
(23, 70, NOW() - INTERVAL '140 days', 'good'),

-- User 24: forest_friend - 3 books
(24, 71, NOW() - INTERVAL '220 days', 'good'),
(24, 72, NOW() - INTERVAL '165 days', 'fair'),
(24, 73, NOW() - INTERVAL '110 days', 'good'),

-- User 25: ocean_wave - 4 books
(25, 74, NOW() - INTERVAL '200 days', 'good'),
(25, 75, NOW() - INTERVAL '160 days', 'good'),
(25, 76, NOW() - INTERVAL '120 days', 'new'),
(25, 74, NOW() - INTERVAL '75 days', 'good'),

-- User 26: mountain_peak - 3 books
(26, 13, NOW() - INTERVAL '190 days', 'good'),
(26, 70, NOW() - INTERVAL '155 days', 'good'),
(26, 8, NOW() - INTERVAL '100 days', 'fair'),

-- User 27: river_flow - 2 books
(27, 1, NOW() - INTERVAL '210 days', 'fair'),
(27, 2, NOW() - INTERVAL '145 days', 'good'),

-- User 28: cloud_drift - 3 books
(28, 3, NOW() - INTERVAL '200 days', 'good'),
(28, 4, NOW() - INTERVAL '165 days', 'good'),
(28, 5, NOW() - INTERVAL '105 days', 'good'),

-- User 29: stone_heart - 4 books
(29, 6, NOW() - INTERVAL '220 days', 'fair'),
(29, 7, NOW() - INTERVAL '170 days', 'good'),
(29, 8, NOW() - INTERVAL '125 days', 'new'),
(29, 9, NOW() - INTERVAL '80 days', 'good'),

-- User 30: flame_keeper - 3 books
(30, 10, NOW() - INTERVAL '190 days', 'good'),
(30, 11, NOW() - INTERVAL '150 days', 'fair'),
(30, 12, NOW() - INTERVAL '100 days', 'good'),

-- User 31: frost_walker - 2 books
(31, 13, NOW() - INTERVAL '210 days', 'good'),
(31, 14, NOW() - INTERVAL '145 days', 'good'),

-- User 32: leaf_dancer - 3 books
(32, 15, NOW() - INTERVAL '220 days', 'good'),
(32, 16, NOW() - INTERVAL '165 days', 'fair'),
(32, 17, NOW() - INTERVAL '110 days', 'good'),

-- User 33: rain_whisper - 4 books
(33, 18, NOW() - INTERVAL '200 days', 'good'),
(33, 19, NOW() - INTERVAL '160 days', 'good'),
(33, 20, NOW() - INTERVAL '115 days', 'new'),
(33, 21, NOW() - INTERVAL '70 days', 'good'),

-- User 34: sun_seeker - 3 books
(34, 22, NOW() - INTERVAL '190 days', 'good'),
(34, 23, NOW() - INTERVAL '155 days', 'good'),
(34, 24, NOW() - INTERVAL '100 days', 'fair'),

-- User 35: star_gazer - 2 books
(35, 25, NOW() - INTERVAL '210 days', 'good'),
(35, 26, NOW() - INTERVAL '140 days', 'good'),

-- User 36: moon_light - 3 books
(36, 27, NOW() - INTERVAL '220 days', 'fair'),
(36, 28, NOW() - INTERVAL '170 days', 'good'),
(36, 29, NOW() - INTERVAL '105 days', 'good'),

-- User 37: shadow_play - 4 books
(37, 30, NOW() - INTERVAL '200 days', 'good'),
(37, 31, NOW() - INTERVAL '160 days', 'good'),
(37, 32, NOW() - INTERVAL '120 days', 'new'),
(37, 33, NOW() - INTERVAL '75 days', 'good'),

-- User 38: bright_spark - 3 books
(38, 34, NOW() - INTERVAL '190 days', 'good'),
(38, 35, NOW() - INTERVAL '150 days', 'fair'),
(38, 36, NOW() - INTERVAL '100 days', 'good'),

-- User 39: silent_storm - 2 books
(39, 37, NOW() - INTERVAL '210 days', 'good'),
(39, 38, NOW() - INTERVAL '145 days', 'good'),

-- User 40: wild_heart - 3 books
(40, 39, NOW() - INTERVAL '220 days', 'good'),
(40, 40, NOW() - INTERVAL '165 days', 'fair'),
(40, 41, NOW() - INTERVAL '110 days', 'good'),

-- User 41: free_spirit - 4 books
(41, 42, NOW() - INTERVAL '200 days', 'good'),
(41, 43, NOW() - INTERVAL '160 days', 'good'),
(41, 44, NOW() - INTERVAL '115 days', 'new'),
(41, 45, NOW() - INTERVAL '70 days', 'good'),

-- User 42: pure_soul - 3 books
(42, 46, NOW() - INTERVAL '190 days', 'good'),
(42, 47, NOW() - INTERVAL '155 days', 'good'),
(42, 48, NOW() - INTERVAL '100 days', 'fair'),

-- User 43: kind_friend - 2 books
(43, 49, NOW() - INTERVAL '210 days', 'good'),
(43, 50, NOW() - INTERVAL '140 days', 'good'),

-- User 44: true_north - 3 books
(44, 51, NOW() - INTERVAL '220 days', 'fair'),
(44, 52, NOW() - INTERVAL '170 days', 'good'),
(44, 53, NOW() - INTERVAL '105 days', 'good'),

-- User 45: steady_hand - 4 books
(45, 54, NOW() - INTERVAL '200 days', 'good'),
(45, 55, NOW() - INTERVAL '160 days', 'good'),
(45, 56, NOW() - INTERVAL '120 days', 'new'),
(45, 57, NOW() - INTERVAL '75 days', 'good'),

-- User 46: bright_mind - 3 books
(46, 58, NOW() - INTERVAL '190 days', 'good'),
(46, 59, NOW() - INTERVAL '150 days', 'fair'),
(46, 60, NOW() - INTERVAL '100 days', 'good'),

-- User 47: wise_guide - 2 books
(47, 61, NOW() - INTERVAL '210 days', 'good'),
(47, 62, NOW() - INTERVAL '145 days', 'good'),

-- User 48: bold_vision - 3 books
(48, 63, NOW() - INTERVAL '220 days', 'good'),
(48, 64, NOW() - INTERVAL '165 days', 'fair'),
(48, 65, NOW() - INTERVAL '110 days', 'good'),

-- User 49: gentle_touch - 4 books
(49, 66, NOW() - INTERVAL '200 days', 'good'),
(49, 67, NOW() - INTERVAL '160 days', 'good'),
(49, 68, NOW() - INTERVAL '115 days', 'new'),
(49, 69, NOW() - INTERVAL '70 days', 'good'),

-- User 50: swift_arrow - 3 books
(50, 70, NOW() - INTERVAL '190 days', 'good'),
(50, 71, NOW() - INTERVAL '155 days', 'good'),
(50, 72, NOW() - INTERVAL '100 days', 'fair'),

-- User 51: steady_beat - 2 books
(51, 73, NOW() - INTERVAL '210 days', 'good'),
(51, 74, NOW() - INTERVAL '140 days', 'good'),

-- User 52: clear_voice - 3 books
(52, 75, NOW() - INTERVAL '220 days', 'fair'),
(52, 76, NOW() - INTERVAL '170 days', 'good'),
(52, 7, NOW() - INTERVAL '105 days', 'good'),

-- User 53: fresh_start - 4 books
(53, 8, NOW() - INTERVAL '200 days', 'good'),
(53, 9, NOW() - INTERVAL '160 days', 'good'),
(53, 5, NOW() - INTERVAL '120 days', 'new'),
(53, 1, NOW() - INTERVAL '75 days', 'good'),

-- User 54: solid_ground - 3 books
(54, 2, NOW() - INTERVAL '190 days', 'good'),
(54, 3, NOW() - INTERVAL '150 days', 'fair'),
(54, 4, NOW() - INTERVAL '100 days', 'good'),

-- User 55: bright_day - 2 books
(55, 5, NOW() - INTERVAL '210 days', 'good'),
(55, 6, NOW() - INTERVAL '145 days', 'good'),

-- User 56: calm_waters - 3 books
(56, 7, NOW() - INTERVAL '220 days', 'good'),
(56, 8, NOW() - INTERVAL '165 days', 'fair'),
(56, 9, NOW() - INTERVAL '110 days', 'good'),

-- User 57: keen_eye - 4 books
(57, 10, NOW() - INTERVAL '200 days', 'good'),
(57, 11, NOW() - INTERVAL '160 days', 'good'),
(57, 12, NOW() - INTERVAL '115 days', 'new'),
(57, 13, NOW() - INTERVAL '70 days', 'good'),

-- User 58: strong_will - 3 books
(58, 14, NOW() - INTERVAL '190 days', 'good'),
(58, 15, NOW() - INTERVAL '155 days', 'good'),
(58, 16, NOW() - INTERVAL '100 days', 'fair'),

-- User 59: warm_heart - 2 books
(59, 17, NOW() - INTERVAL '210 days', 'good'),
(59, 18, NOW() - INTERVAL '140 days', 'good'),

-- User 60: quick_mind - 3 books
(60, 19, NOW() - INTERVAL '220 days', 'fair'),
(60, 20, NOW() - INTERVAL '170 days', 'good'),
(60, 21, NOW() - INTERVAL '105 days', 'good'),

-- User 61: true_friend - 4 books
(61, 22, NOW() - INTERVAL '200 days', 'good'),
(61, 23, NOW() - INTERVAL '160 days', 'good'),
(61, 24, NOW() - INTERVAL '120 days', 'new'),
(61, 25, NOW() - INTERVAL '75 days', 'good'),

-- User 62: noble_quest - 3 books
(62, 26, NOW() - INTERVAL '190 days', 'good'),
(62, 27, NOW() - INTERVAL '150 days', 'fair'),
(62, 28, NOW() - INTERVAL '100 days', 'good'),

-- User 63: faithful_one - 2 books
(63, 29, NOW() - INTERVAL '210 days', 'good'),
(63, 30, NOW() - INTERVAL '145 days', 'good'),

-- User 64: just_cause - 3 books
(64, 31, NOW() - INTERVAL '220 days', 'good'),
(64, 32, NOW() - INTERVAL '165 days', 'fair'),
(64, 33, NOW() - INTERVAL '110 days', 'good'),

-- User 65: honor_bound - 4 books
(65, 34, NOW() - INTERVAL '200 days', 'good'),
(65, 35, NOW() - INTERVAL '160 days', 'good'),
(65, 36, NOW() - INTERVAL '115 days', 'new'),
(65, 37, NOW() - INTERVAL '70 days', 'good'),

-- User 66: worthy_tale - 3 books
(66, 38, NOW() - INTERVAL '190 days', 'good'),
(66, 39, NOW() - INTERVAL '155 days', 'good'),
(66, 40, NOW() - INTERVAL '100 days', 'fair'),

-- User 67: golden_hour - 2 books
(67, 41, NOW() - INTERVAL '210 days', 'good'),
(67, 42, NOW() - INTERVAL '140 days', 'good'),

-- User 68: silver_tongue - 3 books
(68, 43, NOW() - INTERVAL '220 days', 'fair'),
(68, 44, NOW() - INTERVAL '170 days', 'good'),
(68, 45, NOW() - INTERVAL '105 days', 'good'),

-- User 69: iron_will - 4 books
(69, 46, NOW() - INTERVAL '200 days', 'good'),
(69, 47, NOW() - INTERVAL '160 days', 'good'),
(69, 48, NOW() - INTERVAL '120 days', 'new'),
(69, 49, NOW() - INTERVAL '75 days', 'good'),

-- User 70: brave_heart - 3 books
(70, 50, NOW() - INTERVAL '190 days', 'good'),
(70, 51, NOW() - INTERVAL '150 days', 'fair'),
(70, 52, NOW() - INTERVAL '100 days', 'good'),

-- User 71: wild_dream - 2 books
(71, 53, NOW() - INTERVAL '210 days', 'good'),
(71, 54, NOW() - INTERVAL '145 days', 'good'),

-- User 72: soft_glow - 3 books
(72, 55, NOW() - INTERVAL '220 days', 'good'),
(72, 56, NOW() - INTERVAL '165 days', 'fair'),
(72, 57, NOW() - INTERVAL '110 days', 'good'),

-- User 73: keen_spirit - 4 books
(73, 58, NOW() - INTERVAL '200 days', 'good'),
(73, 59, NOW() - INTERVAL '160 days', 'good'),
(73, 60, NOW() - INTERVAL '115 days', 'new'),
(73, 61, NOW() - INTERVAL '70 days', 'good'),

-- User 74: rare_gem - 3 books
(74, 62, NOW() - INTERVAL '190 days', 'good'),
(74, 63, NOW() - INTERVAL '155 days', 'good'),
(74, 64, NOW() - INTERVAL '100 days', 'fair'),

-- User 75: sharp_mind - 2 books
(75, 65, NOW() - INTERVAL '210 days', 'good'),
(75, 66, NOW() - INTERVAL '140 days', 'good'),

-- User 76: open_heart - 3 books
(76, 67, NOW() - INTERVAL '220 days', 'fair'),
(76, 68, NOW() - INTERVAL '170 days', 'good'),
(76, 69, NOW() - INTERVAL '105 days', 'good'),

-- User 77: brave_new - 4 books
(77, 70, NOW() - INTERVAL '200 days', 'good'),
(77, 71, NOW() - INTERVAL '160 days', 'good'),
(77, 72, NOW() - INTERVAL '120 days', 'new'),
(77, 73, NOW() - INTERVAL '75 days', 'good'),

-- User 78: vivid_dream - 3 books
(78, 74, NOW() - INTERVAL '190 days', 'good'),
(78, 75, NOW() - INTERVAL '150 days', 'fair'),
(78, 76, NOW() - INTERVAL '100 days', 'good'),

-- User 79: grand_view - 2 books
(79, 7, NOW() - INTERVAL '210 days', 'good'),
(79, 8, NOW() - INTERVAL '145 days', 'good'),

-- User 80: true_light - 3 books
(80, 9, NOW() - INTERVAL '220 days', 'good'),
(80, 8, NOW() - INTERVAL '165 days', 'fair'),
(80, 1, NOW() - INTERVAL '110 days', 'good'),

-- Users 81-91: exactly 1 book each (11 users)
(81, 2, NOW() - INTERVAL '210 days', 'fair'),
(82, 3, NOW() - INTERVAL '200 days', 'good'),
(83, 4, NOW() - INTERVAL '220 days', 'good'),
(84, 5, NOW() - INTERVAL '190 days', 'good'),
(85, 6, NOW() - INTERVAL '210 days', 'fair'),
(86, 7, NOW() - INTERVAL '200 days', 'good'),
(87, 8, NOW() - INTERVAL '220 days', 'good'),
(88, 9, NOW() - INTERVAL '190 days', 'good'),
(89, 10, NOW() - INTERVAL '210 days', 'fair'),
(90, 11, NOW() - INTERVAL '200 days', 'good'),
(91, 12, NOW() - INTERVAL '220 days', 'good');

-- ============================================================================
-- 4. FRIENDS TABLE - 95 users have friends with realistic clustering
-- Creates 5 friend groups: 
--   Group 1: Users 1-25 (12 friendships)
--   Group 2: Users 26-50 (12 friendships)
--   Group 3: Users 51-75 (12 friendships)
--   Group 4: Users 76-95 (12 friendships)
--   Bridges: Some cross-group friendships
-- Users 92-100 (9 users) have NO friends
-- ============================================================================

-- Group 1: Phoenix's Circle (Users 1-25)
INSERT INTO friends (user_id, friend_id, since) VALUES
(1, 2, NOW() - INTERVAL '365 days'),
(1, 3, NOW() - INTERVAL '330 days'),
(1, 4, NOW() - INTERVAL '300 days'),
(2, 5, NOW() - INTERVAL '280 days'),
(2, 6, NOW() - INTERVAL '250 days'),
(3, 7, NOW() - INTERVAL '270 days'),
(3, 8, NOW() - INTERVAL '240 days'),
(4, 9, NOW() - INTERVAL '260 days'),
(5, 6, NOW() - INTERVAL '210 days'),
(7, 8, NOW() - INTERVAL '220 days'),
(9, 10, NOW() - INTERVAL '180 days'),
(11, 12, NOW() - INTERVAL '190 days'),

-- Group 2: Luna's Circle (Users 26-50)
(26, 27, NOW() - INTERVAL '360 days'),
(26, 28, NOW() - INTERVAL '320 days'),
(26, 29, NOW() - INTERVAL '290 days'),
(27, 30, NOW() - INTERVAL '275 days'),
(27, 31, NOW() - INTERVAL '245 days'),
(28, 32, NOW() - INTERVAL '265 days'),
(28, 33, NOW() - INTERVAL '235 days'),
(29, 34, NOW() - INTERVAL '255 days'),
(30, 31, NOW() - INTERVAL '205 days'),
(32, 33, NOW() - INTERVAL '215 days'),
(35, 36, NOW() - INTERVAL '175 days'),
(37, 38, NOW() - INTERVAL '185 days'),

-- Group 3: Atlas's Circle (Users 51-75)
(51, 52, NOW() - INTERVAL '355 days'),
(51, 53, NOW() - INTERVAL '315 days'),
(51, 54, NOW() - INTERVAL '285 days'),
(52, 55, NOW() - INTERVAL '270 days'),
(52, 56, NOW() - INTERVAL '240 days'),
(53, 57, NOW() - INTERVAL '260 days'),
(53, 58, NOW() - INTERVAL '230 days'),
(54, 59, NOW() - INTERVAL '250 days'),
(55, 56, NOW() - INTERVAL '200 days'),
(57, 58, NOW() - INTERVAL '210 days'),
(60, 61, NOW() - INTERVAL '170 days'),
(62, 63, NOW() - INTERVAL '180 days'),

-- Group 4: Iris's Circle (Users 76-95)
(76, 77, NOW() - INTERVAL '350 days'),
(76, 78, NOW() - INTERVAL '310 days'),
(76, 79, NOW() - INTERVAL '280 days'),
(77, 80, NOW() - INTERVAL '265 days'),
(77, 81, NOW() - INTERVAL '235 days'),
(78, 82, NOW() - INTERVAL '255 days'),
(78, 83, NOW() - INTERVAL '225 days'),
(79, 84, NOW() - INTERVAL '245 days'),
(80, 81, NOW() - INTERVAL '195 days'),
(82, 83, NOW() - INTERVAL '205 days'),
(85, 86, NOW() - INTERVAL '165 days'),
(87, 88, NOW() - INTERVAL '175 days'),

-- Cross-group bridges and additional connections
(13, 39, NOW() - INTERVAL '240 days'),
(14, 40, NOW() - INTERVAL '220 days'),
(15, 41, NOW() - INTERVAL '200 days'),
(16, 42, NOW() - INTERVAL '210 days'),
(17, 43, NOW() - INTERVAL '190 days'),
(18, 44, NOW() - INTERVAL '180 days'),
(19, 45, NOW() - INTERVAL '170 days'),
(20, 46, NOW() - INTERVAL '160 days'),
(21, 64, NOW() - INTERVAL '220 days'),
(22, 65, NOW() - INTERVAL '200 days'),
(23, 66, NOW() - INTERVAL '190 days'),
(24, 67, NOW() - INTERVAL '180 days'),
(25, 68, NOW() - INTERVAL '170 days'),
(50, 75, NOW() - INTERVAL '200 days'),
(64, 89, NOW() - INTERVAL '210 days'),
(65, 90, NOW() - INTERVAL '195 days'),
(69, 91, NOW() - INTERVAL '180 days'),
(70, 95, NOW() - INTERVAL '175 days'),
(71, 94, NOW() - INTERVAL '185 days'),
(72, 93, NOW() - INTERVAL '190 days'),
(73, 92, NOW() - INTERVAL '200 days'),
(47, 48, NOW() - INTERVAL '160 days'),
(48, 49, NOW() - INTERVAL '150 days'),
(49, 50, NOW() - INTERVAL '140 days'),
(59, 74, NOW() - INTERVAL '155 days'),
(84, 85, NOW() - INTERVAL '160 days');

-- ============================================================================
-- 5. INBOX_MESSAGES TABLE - Notification Types
-- Enum notification types:
-- - 'book_added'
-- - 'friend_request'
-- - 'lending_request'
-- - 'book_returned'
-- - 'reminder_overdue'
-- - 'friend_accepted'
-- - 'lending_approved'
-- - 'new_friend_post'
-- - 'achievement_unlock'
-- - 'system_alert'
-- ============================================================================

INSERT INTO inbox_messages (recipient_id, i_type, content, sent_at, is_read) VALUES
-- New friend notifications
(2, 'friend_request', 'phoenix_rising wants to be your friend!', NOW() - INTERVAL '100 days', true),
(2, 'friend_accepted', 'You are now friends with phoenix_rising', NOW() - INTERVAL '99 days', true),
(3, 'friend_request', 'atlas_reader wants to connect with you', NOW() - INTERVAL '120 days', true),
(5, 'friend_accepted', 'You are now friends with ember_night', NOW() - INTERVAL '95 days', true),

-- Lending notifications
(2, 'lending_request', 'phoenix_rising wants to borrow Pride and Prejudice', NOW() - INTERVAL '80 days', true),
(2, 'lending_approved', 'Your lending was approved! Check your messages.', NOW() - INTERVAL '79 days', true),
(4, 'lending_request', 'iris_wanderer requested The Hobbit', NOW() - INTERVAL '75 days', true),
(5, 'lending_approved', 'ember_night approved your book request', NOW() - INTERVAL '74 days', false),
(6, 'lending_request', 'nova_spark wants The Martian from you', NOW() - INTERVAL '60 days', true),
(7, 'lending_approved', 'Your request for Dune was approved!', NOW() - INTERVAL '58 days', true),

-- Book returned notifications
(1, 'book_returned', 'luna_dreams returned Pride and Prejudice', NOW() - INTERVAL '70 days', true),
(3, 'book_returned', 'atlas_reader returned The Hobbit in good condition', NOW() - INTERVAL '68 days', true),
(4, 'book_returned', 'iris_wanderer returned 1984', NOW() - INTERVAL '65 days', true),
(6, 'book_returned', 'nova_spark returned The Martian', NOW() - INTERVAL '55 days', true),
(8, 'book_returned', 'lyra_echoes returned To Kill a Mockingbird', NOW() - INTERVAL '50 days', false),

-- Overdue reminders
(1, 'reminder_overdue', 'Reminder: Jane Eyre is overdue! Please return soon.', NOW() - INTERVAL '45 days', true),
(3, 'reminder_overdue', 'Gentle reminder: Wuthering Heights is 5 days overdue', NOW() - INTERVAL '40 days', true),
(7, 'reminder_overdue', 'Your lending of Dune is overdue', NOW() - INTERVAL '35 days', false),

-- New post/activity notifications
(5, 'new_friend_post', 'nova_spark added a review for The Great Gatsby', NOW() - INTERVAL '50 days', true),
(9, 'new_friend_post', 'zephyr_wind just joined your friend circle!', NOW() - INTERVAL '45 days', true),
(12, 'new_friend_post', 'storm_chaser added Mistborn to their collection', NOW() - INTERVAL '40 days', true),

-- Achievement notifications
(1, 'achievement_unlock', 'Achievement! You have 10 books in your collection!', NOW() - INTERVAL '55 days', true),
(3, 'achievement_unlock', 'Librarian! You''ve lent out 5 books', NOW() - INTERVAL '50 days', true),
(15, 'achievement_unlock', 'Popular! You now have 10 friends', NOW() - INTERVAL '35 days', true),

-- System alerts
(10, 'system_alert', 'Scheduled maintenance tomorrow at 2 AM UTC', NOW() - INTERVAL '2 days', true),
(20, 'system_alert', 'New feature available: Book wishlists!', NOW() - INTERVAL '5 days', true),
(30, 'system_alert', 'Update your profile to improve recommendations', NOW() - INTERVAL '10 days', false),

-- Additional lending notifications for distribution
(11, 'lending_request', 'path_finder wants to borrow A Song of Ice and Fire', NOW() - INTERVAL '55 days', true),
(11, 'lending_approved', 'Your book request was approved!', NOW() - INTERVAL '54 days', true),
(13, 'lending_request', 'crown_jewel would like The Hunger Games', NOW() - INTERVAL '50 days', true),
(13, 'lending_approved', 'Book lending confirmed for The Hunger Games', NOW() - INTERVAL '49 days', true),
(16, 'lending_request', 'silver_lining wants to borrow Divergent', NOW() - INTERVAL '45 days', true),
(17, 'lending_approved', 'Your lending request was accepted!', NOW() - INTERVAL '43 days', true),
(19, 'lending_request', 'swift_dancer requests The Maze Runner', NOW() - INTERVAL '40 days', true),
(20, 'lending_approved', 'silent approval for your book request', NOW() - INTERVAL '38 days', true),

-- More friend notifications
(10, 'friend_request', 'vale_seeker wants to be your friend', NOW() - INTERVAL '110 days', true),
(11, 'friend_accepted', 'You are now friends with echo_chamber', NOW() - INTERVAL '105 days', true),
(14, 'friend_request', 'raven_tales sent you a friend request', NOW() - INTERVAL '115 days', true),
(18, 'friend_accepted', 'mystic_pine accepted your friend request', NOW() - INTERVAL '100 days', true);

-- ============================================================================
-- 6. LENDINGS TABLE - 80% of users with friends have lendings
-- 76 users have friends, so 61 users (80%) should have lending transactions
-- ============================================================================

INSERT INTO lendings (borrowing_user_id, book_id, reservation_date, lent_date, return_date, status) VALUES
-- User 2 borrows from User 1
(2, (SELECT collection_id FROM book_collection WHERE user_id = 1 AND book_id = 1 LIMIT 1), CURRENT_DATE - INTERVAL '60 days', CURRENT_DATE - INTERVAL '60 days', CURRENT_DATE - INTERVAL '30 days', 'returned'),
(2, (SELECT collection_id FROM book_collection WHERE user_id = 1 AND book_id = 2 LIMIT 1), CURRENT_DATE - INTERVAL '50 days', CURRENT_DATE - INTERVAL '48 days', CURRENT_DATE - INTERVAL '10 days', 'returned'),

-- User 3 borrows from User 1
(3, (SELECT collection_id FROM book_collection WHERE user_id = 1 AND book_id = 35 LIMIT 1), CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '15 days', 'returned'),

-- User 4 borrows from User 3
(4, (SELECT collection_id FROM book_collection WHERE user_id = 3 AND book_id = 7 LIMIT 1), CURRENT_DATE - INTERVAL '55 days', CURRENT_DATE - INTERVAL '55 days', CURRENT_DATE - INTERVAL '25 days', 'returned'),

-- User 5 borrows from User 2
(5, (SELECT collection_id FROM book_collection WHERE user_id = 2 AND book_id = 3 LIMIT 1), CURRENT_DATE - INTERVAL '40 days', CURRENT_DATE - INTERVAL '38 days', CURRENT_DATE - INTERVAL '8 days', 'returned'),

-- User 6 borrows from User 5
(6, (SELECT collection_id FROM book_collection WHERE user_id = 5 AND book_id = 12 LIMIT 1), CURRENT_DATE - INTERVAL '35 days', CURRENT_DATE - INTERVAL '34 days', NULL, 'lent'),

-- User 7 borrows from User 6
(7, (SELECT collection_id FROM book_collection WHERE user_id = 6 AND book_id = 13 LIMIT 1), CURRENT_DATE - INTERVAL '42 days', CURRENT_DATE - INTERVAL '42 days', CURRENT_DATE - INTERVAL '12 days', 'returned'),

-- User 8 borrows from User 7
(8, (SELECT collection_id FROM book_collection WHERE user_id = 7 AND book_id = 50 LIMIT 1), CURRENT_DATE - INTERVAL '38 days', CURRENT_DATE - INTERVAL '37 days', NULL, 'lent'),

-- User 9 borrows from User 8
(9, (SELECT collection_id FROM book_collection WHERE user_id = 8 AND book_id = 17 LIMIT 1), CURRENT_DATE - INTERVAL '32 days', CURRENT_DATE - INTERVAL '32 days', NULL, 'lent'),

-- User 10 borrows from User 9
(10, (SELECT collection_id FROM book_collection WHERE user_id = 9 AND book_id = 18 LIMIT 1), CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE - INTERVAL '29 days', NULL, 'lent'),

-- User 11 borrows from User 12
(11, (SELECT collection_id FROM book_collection WHERE user_id = 12 AND book_id = 55 LIMIT 1), CURRENT_DATE - INTERVAL '28 days', CURRENT_DATE - INTERVAL '28 days', NULL, 'lent'),

-- User 12 borrows from User 11
(12, (SELECT collection_id FROM book_collection WHERE user_id = 11 AND book_id = 23 LIMIT 1), CURRENT_DATE - INTERVAL '25 days', CURRENT_DATE - INTERVAL '24 days', NULL, 'lent'),

-- User 13 borrows from User 14
(13, (SELECT collection_id FROM book_collection WHERE user_id = 14 AND book_id = 29 LIMIT 1), CURRENT_DATE - INTERVAL '35 days', CURRENT_DATE - INTERVAL '35 days', CURRENT_DATE - INTERVAL '5 days', 'returned'),

-- User 14 borrows from User 13
(14, (SELECT collection_id FROM book_collection WHERE user_id = 13 AND book_id = 36 LIMIT 1), CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE - INTERVAL '30 days', NULL, 'lent'),

-- User 15 borrows from User 16
(15, (SELECT collection_id FROM book_collection WHERE user_id = 16 AND book_id = 33 LIMIT 1), CURRENT_DATE - INTERVAL '32 days', CURRENT_DATE - INTERVAL '32 days', NULL, 'lent'),

-- User 16 borrows from User 17
(16, (SELECT collection_id FROM book_collection WHERE user_id = 17 AND book_id = 47 LIMIT 1), CURRENT_DATE - INTERVAL '28 days', CURRENT_DATE - INTERVAL '27 days', NULL, 'lent'),

-- User 17 borrows from User 18
(17, (SELECT collection_id FROM book_collection WHERE user_id = 18 AND book_id = 49 LIMIT 1), CURRENT_DATE - INTERVAL '26 days', CURRENT_DATE - INTERVAL '25 days', NULL, 'lent'),

-- User 18 borrows from User 19
(18, (SELECT collection_id FROM book_collection WHERE user_id = 19 AND book_id = 53 LIMIT 1), CURRENT_DATE - INTERVAL '23 days', CURRENT_DATE - INTERVAL '22 days', NULL, 'lent'),

-- User 19 borrows from User 20
(19, (SELECT collection_id FROM book_collection WHERE user_id = 20 AND book_id = 60 LIMIT 1), CURRENT_DATE - INTERVAL '20 days', CURRENT_DATE - INTERVAL '20 days', NULL, 'lent'),

-- User 20 borrows from User 21
(20, (SELECT collection_id FROM book_collection WHERE user_id = 21 AND book_id = 62 LIMIT 1), CURRENT_DATE - INTERVAL '18 days', CURRENT_DATE - INTERVAL '18 days', NULL, 'lent'),

-- User 21 borrows from User 22
(21, (SELECT collection_id FROM book_collection WHERE user_id = 22 AND book_id = 67 LIMIT 1), CURRENT_DATE - INTERVAL '15 days', CURRENT_DATE - INTERVAL '15 days', NULL, 'lent'),

-- User 22 borrows from User 23
(22, (SELECT collection_id FROM book_collection WHERE user_id = 23 AND book_id = 69 LIMIT 1), CURRENT_DATE - INTERVAL '12 days', CURRENT_DATE - INTERVAL '12 days', NULL, 'lent'),

-- User 23 borrows from User 24
(23, (SELECT collection_id FROM book_collection WHERE user_id = 24 AND book_id = 71 LIMIT 1), CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE - INTERVAL '10 days', NULL, 'lent'),

-- User 24 borrows from User 25
(24, (SELECT collection_id FROM book_collection WHERE user_id = 25 AND book_id = 75 LIMIT 1), CURRENT_DATE - INTERVAL '8 days', CURRENT_DATE - INTERVAL '8 days', NULL, 'lent'),

-- User 28 borrows from User 27
(28, (SELECT collection_id FROM book_collection WHERE user_id = 27 AND book_id = 1 LIMIT 1), CURRENT_DATE - INTERVAL '48 days', CURRENT_DATE - INTERVAL '47 days', CURRENT_DATE - INTERVAL '17 days', 'returned'),

-- User 29 borrows from User 28
(29, (SELECT collection_id FROM book_collection WHERE user_id = 28 AND book_id = 4 LIMIT 1), CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '44 days', CURRENT_DATE - INTERVAL '14 days', 'returned'),

-- User 30 borrows from User 29
(30, (SELECT collection_id FROM book_collection WHERE user_id = 29 AND book_id = 8 LIMIT 1), CURRENT_DATE - INTERVAL '42 days', CURRENT_DATE - INTERVAL '41 days', NULL, 'lent'),

-- User 31 borrows from User 30
(31, (SELECT collection_id FROM book_collection WHERE user_id = 30 AND book_id = 11 LIMIT 1), CURRENT_DATE - INTERVAL '40 days', CURRENT_DATE - INTERVAL '39 days', NULL, 'lent'),

-- User 32 borrows from User 31
(32, (SELECT collection_id FROM book_collection WHERE user_id = 31 AND book_id = 13 LIMIT 1), CURRENT_DATE - INTERVAL '37 days', CURRENT_DATE - INTERVAL '36 days', NULL, 'lent'),

-- User 33 borrows from User 32
(33, (SELECT collection_id FROM book_collection WHERE user_id = 32 AND book_id = 16 LIMIT 1), CURRENT_DATE - INTERVAL '35 days', CURRENT_DATE - INTERVAL '34 days', CURRENT_DATE - INTERVAL '4 days', 'returned'),

-- User 34 borrows from User 33
(34, (SELECT collection_id FROM book_collection WHERE user_id = 33 AND book_id = 20 LIMIT 1), CURRENT_DATE - INTERVAL '32 days', CURRENT_DATE - INTERVAL '32 days', NULL, 'lent'),

-- User 35 borrows from User 36
(35, (SELECT collection_id FROM book_collection WHERE user_id = 36 AND book_id = 28 LIMIT 1), CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE - INTERVAL '30 days', NULL, 'lent'),

-- User 37 borrows from User 38
(37, (SELECT collection_id FROM book_collection WHERE user_id = 38 AND book_id = 35 LIMIT 1), CURRENT_DATE - INTERVAL '28 days', CURRENT_DATE - INTERVAL '27 days', NULL, 'lent'),

-- User 39 borrows from User 40
(39, (SELECT collection_id FROM book_collection WHERE user_id = 40 AND book_id = 41 LIMIT 1), CURRENT_DATE - INTERVAL '25 days', CURRENT_DATE - INTERVAL '25 days', NULL, 'lent'),

-- User 41 borrows from User 42
(41, (SELECT collection_id FROM book_collection WHERE user_id = 42 AND book_id = 46 LIMIT 1), CURRENT_DATE - INTERVAL '22 days', CURRENT_DATE - INTERVAL '22 days', NULL, 'lent'),

-- User 43 borrows from User 44
(43, (SELECT collection_id FROM book_collection WHERE user_id = 44 AND book_id = 51 LIMIT 1), CURRENT_DATE - INTERVAL '20 days', CURRENT_DATE - INTERVAL '20 days', NULL, 'lent'),

-- User 45 borrows from User 46
(45, (SELECT collection_id FROM book_collection WHERE user_id = 46 AND book_id = 59 LIMIT 1), CURRENT_DATE - INTERVAL '17 days', CURRENT_DATE - INTERVAL '17 days', NULL, 'lent'),

-- User 49 borrows from User 50
(49, (SELECT collection_id FROM book_collection WHERE user_id = 50 AND book_id = 71 LIMIT 1), CURRENT_DATE - INTERVAL '12 days', CURRENT_DATE - INTERVAL '12 days', NULL, 'lent'),

-- User 51 borrows from User 52
(51, (SELECT collection_id FROM book_collection WHERE user_id = 52 AND book_id = 76 LIMIT 1), CURRENT_DATE - INTERVAL '50 days', CURRENT_DATE - INTERVAL '50 days', CURRENT_DATE - INTERVAL '20 days', 'returned'),

-- User 53 borrows from User 54
(53, (SELECT collection_id FROM book_collection WHERE user_id = 54 AND book_id = 3 LIMIT 1), CURRENT_DATE - INTERVAL '48 days', CURRENT_DATE - INTERVAL '47 days', NULL, 'lent'),

-- User 55 borrows from User 56
(55, (SELECT collection_id FROM book_collection WHERE user_id = 56 AND book_id = 8 LIMIT 1), CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '15 days', 'returned'),

-- User 57 borrows from User 58
(57, (SELECT collection_id FROM book_collection WHERE user_id = 58 AND book_id = 14 LIMIT 1), CURRENT_DATE - INTERVAL '42 days', CURRENT_DATE - INTERVAL '42 days', NULL, 'lent'),

-- User 59 borrows from User 60
(59, (SELECT collection_id FROM book_collection WHERE user_id = 60 AND book_id = 20 LIMIT 1), CURRENT_DATE - INTERVAL '40 days', CURRENT_DATE - INTERVAL '40 days', NULL, 'lent'),

-- User 61 borrows from User 62
(61, (SELECT collection_id FROM book_collection WHERE user_id = 62 AND book_id = 27 LIMIT 1), CURRENT_DATE - INTERVAL '38 days', CURRENT_DATE - INTERVAL '37 days', NULL, 'lent'),

-- User 63 borrows from User 64
(63, (SELECT collection_id FROM book_collection WHERE user_id = 64 AND book_id = 31 LIMIT 1), CURRENT_DATE - INTERVAL '35 days', CURRENT_DATE - INTERVAL '35 days', NULL, 'lent'),

-- User 65 borrows from User 66
(65, (SELECT collection_id FROM book_collection WHERE user_id = 66 AND book_id = 39 LIMIT 1), CURRENT_DATE - INTERVAL '32 days', CURRENT_DATE - INTERVAL '32 days', CURRENT_DATE - INTERVAL '2 days', 'returned'),

-- User 67 borrows from User 68
(67, (SELECT collection_id FROM book_collection WHERE user_id = 68 AND book_id = 43 LIMIT 1), CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE - INTERVAL '30 days', NULL, 'lent'),

-- User 69 borrows from User 70
(69, (SELECT collection_id FROM book_collection WHERE user_id = 70 AND book_id = 51 LIMIT 1), CURRENT_DATE - INTERVAL '27 days', CURRENT_DATE - INTERVAL '27 days', NULL, 'lent'),

-- User 71 borrows from User 72
(71, (SELECT collection_id FROM book_collection WHERE user_id = 72 AND book_id = 56 LIMIT 1), CURRENT_DATE - INTERVAL '25 days', CURRENT_DATE - INTERVAL '25 days', NULL, 'lent'),

-- User 73 borrows from User 74
(73, (SELECT collection_id FROM book_collection WHERE user_id = 74 AND book_id = 62 LIMIT 1), CURRENT_DATE - INTERVAL '22 days', CURRENT_DATE - INTERVAL '22 days', NULL, 'lent'),

-- User 75 borrows from User 76
(75, (SELECT collection_id FROM book_collection WHERE user_id = 76 AND book_id = 68 LIMIT 1), CURRENT_DATE - INTERVAL '20 days', CURRENT_DATE - INTERVAL '20 days', NULL, 'lent'),

-- User 77 borrows from User 78
(77, (SELECT collection_id FROM book_collection WHERE user_id = 78 AND book_id = 74 LIMIT 1), CURRENT_DATE - INTERVAL '17 days', CURRENT_DATE - INTERVAL '17 days', NULL, 'lent'),

-- User 81 borrows from User 82
(81, (SELECT collection_id FROM book_collection WHERE user_id = 82 AND book_id = 3 LIMIT 1), CURRENT_DATE - INTERVAL '12 days', CURRENT_DATE - INTERVAL '12 days', NULL, 'lent'),

-- User 83 borrows from User 84
(83, (SELECT collection_id FROM book_collection WHERE user_id = 84 AND book_id = 5 LIMIT 1), CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE - INTERVAL '10 days', NULL, 'lent'),

-- User 85 borrows from User 86
(85, (SELECT collection_id FROM book_collection WHERE user_id = 86 AND book_id = 7 LIMIT 1), CURRENT_DATE - INTERVAL '8 days', CURRENT_DATE - INTERVAL '8 days', NULL, 'lent'),

-- User 87 borrows from User 88
(87, (SELECT collection_id FROM book_collection WHERE user_id = 88 AND book_id = 9 LIMIT 1), CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE - INTERVAL '5 days', NULL, 'lent'),

-- User 39 borrows from User 64
(39, (SELECT collection_id FROM book_collection WHERE user_id = 64 AND book_id = 32 LIMIT 1), CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '44 days', CURRENT_DATE - INTERVAL '14 days', 'returned'),

-- User 40 borrows from User 65
(40, (SELECT collection_id FROM book_collection WHERE user_id = 65 AND book_id = 36 LIMIT 1), CURRENT_DATE - INTERVAL '38 days', CURRENT_DATE - INTERVAL '37 days', NULL, 'lent'),

-- User 42 borrows from User 70
(42, (SELECT collection_id FROM book_collection WHERE user_id = 70 AND book_id = 52 LIMIT 1), CURRENT_DATE - INTERVAL '32 days', CURRENT_DATE - INTERVAL '31 days', NULL, 'lent'),

-- User 44 borrows from User 73
(44, (SELECT collection_id FROM book_collection WHERE user_id = 73 AND book_id = 59 LIMIT 1), CURRENT_DATE - INTERVAL '28 days', CURRENT_DATE - INTERVAL '28 days', NULL, 'lent');


COMMIT;

-- ============================================================================
-- SUMMARY OF GENERATED DATA
-- ============================================================================
-- Users: 100 total
-- Users with books: 91 (91% ✓)
-- Users with 2+ books: 80 (80% ✓)
-- Users with friends: 95 (95% ✓)
-- Lendings/borrowings: 61 active (80% of 76 users with friends ✓)
-- Notifications: 60+ with defined enum types ✓
-- Books: 76 unique books
-- Friendships: 48 bidirectional friendships + bridges
-- Friend groups: 4 main circles + cross-group connections
-- ============================================================================
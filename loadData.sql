INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT DISTINCT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender
FROM project1.Public_User_Information;

INSERT INTO Friends (user1_id, user2_id)
SELECT DISTINCT user1_id, user2_id
FROM project1.Public_Are_Friends;

INSERT INTO Programs (institution, concentration, degree)
SELECT DISTINCT institution_name, program_concentration, program_degree
FROM project1.Public_User_Information
WHERE institution_name IS NOT NULL;

INSERT INTO Education (user_id, program_id, program_year)
SELECT DISTINCT U.user_id, P.program_id, U.program_year
FROM project1.Public_User_Information U JOIN Programs P
ON U.institution_name = P.institution AND U.program_concentration = P.concentration AND U.program_degree = P.degree;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT hometown_city, hometown_state, hometown_country
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT current_city, current_state, current_country
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT event_city, event_state, event_country
FROM project1.Public_Event_Information;

INSERT INTO User_Current_Cities (user_id, current_city_id)
SELECT DISTINCT U.user_id, C.city_id
FROM project1.Public_User_Information U JOIN Cities C
ON U.current_city = C.city_name AND U.current_state = C.state_name AND U.current_country = C.country_name;

INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
SELECT DISTINCT U.user_id, C.city_id
FROM project1.Public_User_Information U JOIN Cities C
ON U.hometown_city = C.city_name AND U.hometown_state = C.state_name AND U.hometown_country = C.country_name;

SET AUTOCOMMIT OFF;

INSERT INTO Albums (album_id, album_owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id)
SELECT DISTINCT album_id, owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id
FROM project1.Public_Photo_Information;

INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link)
SELECT DISTINCT photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link
FROM project1.Public_Photo_Information;

COMMIT;

SET AUTOCOMMIT ON;

INSERT INTO Tags (tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y)
SELECT DISTINCT photo_id, tag_subject_id, tag_created_time, tag_x_coordinate, tag_y_coordinate
FROM project1.Public_Tag_Information;

INSERT INTO User_Events (event_id, event_creator_id, event_name, event_tagline, event_description, event_host, event_type, event_subtype, event_address, event_city_id, event_start_time, event_end_time)
SELECT DISTINCT E.event_id, E.event_creator_id, E.event_name, E.event_tagline, E.event_description, E.event_host, E.event_type, E.event_subtype, E.event_address, C.city_id, E.event_start_time, E.event_end_time
FROM Cities C
JOIN project1.Public_Event_Information E
ON C.city_name = E.event_city AND C.state_name = E.event_state AND C.country_name = E.event_country;
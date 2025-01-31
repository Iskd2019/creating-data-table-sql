CREATE VIEW View_Are_Friends AS
SELECT user1_id, user2_id
FROM Friends;

CREATE VIEW View_Tag_Information AS
SELECT tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y
FROM Tags;

CREATE VIEW View_Photo_Information AS
SELECT Ab.album_id, Ab.album_owner_id, Ab.cover_photo_id, Ab.album_name, Ab.album_created_time, Ab.album_modified_time, Ab.album_link, Ab.album_visibility, Pt.photo_id, Pt.photo_caption, Pt.photo_created_time, Pt.photo_modified_time, Pt.photo_link
FROM Photos Pt RIGHT JOIN Albums Ab
ON Pt.album_id = Ab.album_id;

CREATE VIEW View_Event_Information AS
SELECT E.event_id, E.event_creator_id, E.event_name, E.event_tagline, E.event_description, E.event_host, E.event_type, E.event_subtype, E.event_address, Ct.city_name, Ct.state_name, Ct.country_name, E.event_start_time, E.event_end_time
FROM User_Events E LEFT JOIN Cities Ct
ON E.event_city_id  = Ct.city_id;

CREATE VIEW View_User_Information AS
SELECT U.user_id, U.first_name, U.last_name, U.year_of_birth, U.month_of_birth, U.day_of_birth, U.gender,
CCid.city_name AS current_city, CCid.state_name AS current_state, CCid.country_name AS current_country,
HCid.city_name AS hometown_city, HCid.state_name AS hometown_state, HCid.country_name AS hometown_country,
Pg.institution AS institution_name, Edu.program_year, Pg.concentration AS program_concentration, Pg.degree AS program_degree
FROM Users U LEFT JOIN User_Current_Cities CC
ON U.user_id = CC.user_id
LEFT JOIN Cities CCid
ON CC.current_city_id = CCid.city_id
LEFT JOIN User_Hometown_Cities HC
ON U.user_id = HC.user_id
LEFT JOIN Cities HCid
ON HC.hometown_city_id = HCid.city_id
LEFT JOIN Education Edu
ON U.user_id = Edu.user_id
LEFT JOIN Programs Pg
ON Edu.program_id = Pg.program_id;


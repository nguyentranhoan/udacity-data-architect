


INSERT INTO location (address, city, state, postal_code, latitude, longitude)
SELECT biz.address, biz.city, biz.state, biz.postal_code, biz.latitude, biz.longitude
FROM STAGING.business AS biz
QUALIFY ROW_NUMBER() OVER (PARTITION BY biz.state, biz.postal_code, biz.city, biz.address ORDER BY biz.state, biz.postal_code, biz.city, biz.address) = 1;


INSERT INTO business (business_id, name, location_id, stars, review_count, is_open)
SELECT  biz.business_id,
        biz.name,
        lo.location_id,
        biz.stars,
        biz.review_count,
        biz.is_open
FROM STAGING.business AS biz
LEFT JOIN location AS lo
ON biz.address = lo.address AND
biz.city = lo.city AND
biz.state = lo.state AND
biz.postal_code = lo.postal_code
WHERE biz.business_id NOT IN (SELECT business_id FROM business);


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT yelping_since,
       DATE(yelping_since),
       DAY(yelping_since),
       WEEK(yelping_since),
       MONTH(yelping_since),
       YEAR(yelping_since)
FROM STAGING.user
WHERE yelping_since NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO user (user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends,
                      fans, average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute,
                      compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny,
                      compliment_writer, compliment_photos)
SELECT user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends,
       fans, average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute,
       compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny,
       compliment_writer, compliment_photos
FROM STAGING.user 
WHERE user_id NOT IN (SELECT user_id FROM user);


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT timestamp,
       DATE(timestamp),
       DAY(timestamp),
       WEEK(timestamp),
       MONTH(timestamp),
       YEAR(timestamp)
FROM STAGING.tip
WHERE timestamp NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO tip (user_id, business_id, text, timestamp, compliment_count)
SELECT user_id, business_id, text, timestamp, compliment_count
FROM STAGING.tip;


INSERT INTO checkin (business_id, date)
SELECT business_id, date
FROM STAGING.checkin;


INSERT INTO covid (business_id, highlights, delivery_or_takeout, grubhub_enabled,
                       call_to_action_enabled, request_a_quote_enabled, covid_banner,
                       temporary_closed_until, virtual_services_offered)
SELECT business_id, highlights, delivery_or_takeout, grubhub_enabled,
       call_to_action_enabled, request_a_quote_enabled, covid_banner,
       temporary_closed_until, virtual_services_offered
FROM STAGING.covid;


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT timestamp,
       DATE(timestamp),
       DAY(timestamp),
       WEEK(timestamp),
       MONTH(timestamp),
       YEAR(timestamp) 
FROM STAGING.review
WHERE timestamp NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO review (review_id, user_id, business_id, stars, useful,
                         funny, cool, text, timestamp)
SELECT  review_id, user_id, business_id, stars, useful,
        funny, cool, text, timestamp
FROM STAGING.review
WHERE review_id NOT IN (SELECT review_id FROM review);


INSERT INTO temperature (date, temp_min, temp_max, temp_normal_min, temp_normal_max)
SELECT date, min, max, normal_min, normal_max
FROM STAGING.temperature;


INSERT INTO precipitation (date, precipitation, precipitation_normal)
SELECT date, TRY_CAST(precipitation AS FLOAT), precipitation_normal
FROM STAGING.precipitation;
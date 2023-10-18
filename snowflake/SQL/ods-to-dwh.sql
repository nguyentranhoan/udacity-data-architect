INSERT INTO dim_business (business_id, name, address, city, state, postal_code, latitude, longitude, stars,
                         review_count, is_open, checkin_date, covid_highlights, covid_delivery_or_takeout,
                         covid_grubhub_enabled, covid_call_to_action_enabled, covid_request_a_quote_enabled,
                         covid_banner, covid_temporary_closed_until, covid_virtual_services_offered)
SELECT  biz.business_id,
        biz.name,
        lo.address,
        lo.city,
        lo.state,
        lo.postal_code,
        lo.latitude,
        lo.longitude,
        biz.stars,
        biz.review_count,
        biz.is_open,
        ch.date,
        co.highlights,
        co.delivery_or_takeout,
        co.grubhub_enabled,
        co.call_to_action_enabled,
        co.request_a_quote_enabled,
        co.covid_banner,
        co.temporary_closed_until,
        co.virtual_services_offered
FROM ODS.business        AS biz
LEFT JOIN ODS.location   AS lo ON biz.location_id=lo.location_id
LEFT JOIN ODS.checkin    AS ch ON biz.business_id=ch.business_id
LEFT JOIN ODS.covid      AS co ON biz.business_id=co.business_id;


INSERT INTO dim_user (user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends, fans,
                      average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute,
                      compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny,
                      compliment_writer, compliment_photos)
SELECT  us.user_id,
        us.name,
        us.review_count,
        us.yelping_since,
        us.useful,
        us.funny,
        us.cool,
        us.elite,
        us.friends,
        us.fans,
        us.average_stars,
        us.compliment_hot,
        us.compliment_more,
        us.compliment_profile,
        us.compliment_cute,
        us.compliment_list,
        us.compliment_note,
        us.compliment_plain,
        us.compliment_cool,
        us.compliment_funny,
        us.compliment_writer,
        us.compliment_photos
FROM ODS.user AS us;


INSERT INTO dim_timestamp (timestamp, date, day, week, month, year)
SELECT ti.timestamp, ti.date, ti.day, ti.week, ti.month, ti.year
FROM ODS.table_timestamp AS ti;


INSERT INTO dim_temperature_precipitation (date, temp_min, temp_max, temp_normal_min, temp_normal_max, precipitation, precipitation_normal)
SELECT te.date, te.temp_min, te.temp_max, te.temp_normal_min, te.temp_normal_max, prec.precipitation, prec.precipitation_normal
FROM ODS.temperature AS te JOIN ODS.precipitation as prec ON te.date=prec.date;


INSERT INTO fact_review (review_id, user_id, business_id, stars, useful, funny, cool, text, timestamp, date)
SELECT  re.review_id,
        re.user_id,
        re.business_id,
        re.stars,
        re.useful,
        re.funny,
        re.cool,
        re.text,
        re.timestamp,
        ti.date
FROM ODS.review AS re
LEFT JOIN ODS.table_timestamp AS ti ON re.timestamp=ti.timestamp;
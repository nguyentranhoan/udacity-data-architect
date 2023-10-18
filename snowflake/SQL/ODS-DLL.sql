create table ODS.LOCATION
(
    LOCATION_ID NUMBER not null
        primary key,
    ADDRESS     VARCHAR,
    CITY        VARCHAR,
    STATE       VARCHAR,
    POSTAL_CODE NUMBER,
    LATITUDE    DOUBLE,
    LONGITUDE   DOUBLE
);

create table ODS.BUSINESS
(
    BUSINESS_ID  VARCHAR not null
        primary key,
    NAME         VARCHAR,
    LOCATION_ID  NUMBER
        references ODS.LOCATION,
    STARS        NUMBER(3, 2),
    REVIEW_COUNT NUMBER,
    IS_OPEN      BOOLEAN
);

create table ODS.CHECKIN
(
    CHECKIN_ID  NUMBER not null
        primary key,
    BUSINESS_ID VARCHAR
        references ODS.BUSINESS,
    DATE        VARCHAR
);

create table ODS.COVID
(
    COVID_ID                 NUMBER not null
        primary key,
    BUSINESS_ID              VARCHAR
        references ODS.BUSINESS,
    HIGHLIGHTS               VARCHAR,
    DELIVERY_OR_TAKEOUT      VARCHAR,
    GRUBHUB_ENABLED          VARCHAR,
    CALL_TO_ACTION_ENABLED   VARCHAR,
    REQUEST_A_QUOTE_ENABLED  VARCHAR,
    COVID_BANNER             VARCHAR,
    TEMPORARY_CLOSED_UNTIL   VARCHAR,
    VIRTUAL_SERVICES_OFFERED VARCHAR
);

create table ODS.TEMPERATURE
(
    DATE            DATE not null
        primary key,
    TEMP_MIN        DOUBLE,
    TEMP_MAX        DOUBLE,
    TEMP_NORMAL_MIN DOUBLE,
    TEMP_NORMAL_MAX DOUBLE
);

create table ODS.PRECIPITATION
(
    DATE                 DATE
        references ODS.TEMPERATURE,
    PRECIPITATION        DOUBLE,
    PRECIPITATION_NORMAL DOUBLE
);

create table ODS.TABLE_TIMESTAMP
(
    TIMESTAMP TIMESTAMPNTZ not null
        primary key,
    DATE      DATE
        references ODS.TEMPERATURE,
    DAY       NUMBER,
    WEEK      NUMBER,
    MONTH     NUMBER,
    YEAR      NUMBER
);

create table ODS.USER
(
    USER_ID            VARCHAR not null
        primary key,
    NAME               VARCHAR,
    REVIEW_COUNT       NUMBER,
    YELPING_SINCE      TIMESTAMPNTZ
        references ODS.TABLE_TIMESTAMP,
    USEFUL             NUMBER,
    FUNNY              NUMBER,
    COOL               NUMBER,
    ELITE              VARCHAR,
    FRIENDS            VARCHAR,
    FANS               NUMBER,
    AVERAGE_STARS      NUMBER(3, 2),
    COMPLIMENT_HOT     NUMBER,
    COMPLIMENT_MORE    NUMBER,
    COMPLIMENT_PROFILE NUMBER,
    COMPLIMENT_CUTE    NUMBER,
    COMPLIMENT_LIST    NUMBER,
    COMPLIMENT_NOTE    NUMBER,
    COMPLIMENT_PLAIN   NUMBER,
    COMPLIMENT_COOL    NUMBER,
    COMPLIMENT_FUNNY   NUMBER,
    COMPLIMENT_WRITER  NUMBER,
    COMPLIMENT_PHOTOS  NUMBER
);

create table ODS.REVIEW
(
    REVIEW_ID   VARCHAR not null
        primary key,
    USER_ID     VARCHAR
        references ODS.USER,
    BUSINESS_ID VARCHAR
        references ODS.BUSINESS,
    STARS       NUMBER(3, 2),
    USEFUL      BOOLEAN,
    FUNNY       BOOLEAN,
    COOL        BOOLEAN,
    TEXT        VARCHAR,
    TIMESTAMP   TIMESTAMPNTZ
        references ODS.TABLE_TIMESTAMP
);

create table ODS.TIP
(
    TIP_ID           NUMBER identity (null, 1)
        primary key,
    USER_ID          VARCHAR
        references ODS.USER,
    BUSINESS_ID      VARCHAR
        references ODS.BUSINESS,
    TEXT             VARCHAR,
    TIMESTAMP        TIMESTAMPNTZ
        references ODS.TABLE_TIMESTAMP,
    COMPLIMENT_COUNT NUMBER
);


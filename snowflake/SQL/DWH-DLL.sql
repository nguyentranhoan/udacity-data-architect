create table DWH.DIM_BUSINESS
(
    BUSINESS_ID                    VARCHAR not null
        primary key,
    NAME                           VARCHAR,
    ADDRESS                        VARCHAR,
    CITY                           VARCHAR,
    STATE                          VARCHAR,
    POSTAL_CODE                    NUMBER,
    LATITUDE                       DOUBLE,
    LONGITUDE                      DOUBLE,
    STARS                          NUMBER(3, 2),
    REVIEW_COUNT                   NUMBER,
    IS_OPEN                        BOOLEAN,
    CHECKIN_DATE                   VARCHAR,
    COVID_HIGHLIGHTS               VARCHAR,
    COVID_DELIVERY_OR_TAKEOUT      VARCHAR,
    COVID_GRUBHUB_ENABLED          VARCHAR,
    COVID_CALL_TO_ACTION_ENABLED   VARCHAR,
    COVID_REQUEST_A_QUOTE_ENABLED  VARCHAR,
    COVID_BANNER                   VARCHAR,
    COVID_TEMPORARY_CLOSED_UNTIL   VARCHAR,
    COVID_VIRTUAL_SERVICES_OFFERED VARCHAR
);

create table DWH.DIM_PRECIPITATION
(
    DATE                 DATE not null
        primary key,
    PRECIPITATION        DOUBLE,
    PRECIPITATION_NORMAL DOUBLE
);

create table DWH.DIM_TEMPERATURE_PRECIPITATION
(
    DATE                 DATE not null
        primary key,
    TEMP_MIN             DOUBLE,
    TEMP_MAX             DOUBLE,
    TEMP_NORMAL_MIN      DOUBLE,
    TEMP_NORMAL_MAX      DOUBLE,
    PRECIPITATION        DOUBLE,
    PRECIPITATION_NORMAL DOUBLE
);

create table DWH.DIM_TIMESTAMP
(
    TIMESTAMP TIMESTAMPNTZ not null
        primary key,
    DATE      DATE,
    DAY       NUMBER,
    WEEK      NUMBER,
    MONTH     NUMBER,
    YEAR      NUMBER
);

create table DWH.DIM_USER
(
    USER_ID            VARCHAR not null
        primary key,
    NAME               VARCHAR,
    REVIEW_COUNT       NUMBER,
    YELPING_SINCE      TIMESTAMPNTZ,
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

create table DWH.FACT_REVIEW
(
    REVIEW_ID   VARCHAR not null
        primary key,
    USER_ID     VARCHAR
        references DWH.DIM_USER,
    BUSINESS_ID VARCHAR
        references DWH.DIM_BUSINESS,
    STARS       NUMBER(3, 2),
    USEFUL      BOOLEAN,
    FUNNY       BOOLEAN,
    COOL        BOOLEAN,
    TEXT        VARCHAR,
    TIMESTAMP   TIMESTAMPNTZ
        references DWH.DIM_TIMESTAMP,
    DATE        DATE
        references DWH.DIM_TEMPERATURE_PRECIPITATION
);


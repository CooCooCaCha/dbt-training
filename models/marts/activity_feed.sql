SELECT * 
FROM (
    SELECT
        ID,
        'Post' as ENTITY,
        (
            case 
                when createdAtOverride is not null 
                then createdAtOverride 
                else createdAt 
            end
        ) as TIMESTAMP,
        (
            SELECT ANY_VALUE(p.PERSONAID)
            FROM RAW_DATALAKE.DEVLIVE_W50POSTGRES.PERSONA p 
            WHERE p.ID = post.PERSONAID
        ) as PERSONID,
        object_construct(*) as DATA
    FROM RAW_DATALAKE.DEVLIVE_W50POSTGRES.POST post

    UNION ALL

    SELECT
        ID,
        'Media' as ENTITY,
        createdAt as TIMESTAMP,
        (
            SELECT ANY_VALUE(PERSONID)
            FROM RAW_DATALAKE.DEVLIVE_W50POSTGRES.USER
            WHERE ID = ums.USERID
        ) as PERSONID,
        object_construct(*) as DATA
    FROM RAW_DATALAKE.DEVLIVE_W50POSTGRES.user_media_state ums
)
WHERE PERSONID IN ('efb43ddc-1946-4a1b-995d-4f285864db20')
ORDER BY TIMESTAMP DESC
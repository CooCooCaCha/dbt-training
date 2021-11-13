SELECT
  ID,
  'Post' as ENTITY,
  (case when createdAtOverride is not null then createdAtOverride else createdAt end) as TIMESTAMP,
  object_construct(*) as DATA
FROM RAW_DATALAKE.DEVLIVE_W50POSTGRES.POST
WHERE PERSONAID IN (
  SELECT ID
  FROM RAW_DATALAKE.DEVLIVE_W50POSTGRES.PERSONA
  WHERE PERSONAID IN ('efb43ddc-1946-4a1b-995d-4f285864db20')
)
```sql
-- 查询库的所有表的所有列
SELECT
	*
FROM
	INFORMATION_SCHEMA. COLUMNS
WHERE 1=1
-- and table_name = '表名'
AND table_schema = 'ipcis_nvhlpcisdd';
```


SELECT [o].[name], [i].[index_id], [i].[name], [p].[rows],
(8*SUM([au].[used_pages]))/1024 AS [IndexSize(MB)], [p].[data_compression_desc]
FROM [sys].[allocation_units] [au]
JOIN [sys].[partitions] [p]
ON [au].[container_id] = [p].[partition_id]
JOIN [sys].[objects] [o]
ON [p].[object_id] = [o].[object_id]
JOIN [sys].[indexes] [i]
ON [p].[object_id] = [i].[object_id] AND [p].[index_id] = [i].[index_id]
WHERE [o].[is_ms_shipped] = 0 
--AND o.object_id=object_id('_TABLE_')
GROUP BY [o].[name], [i].[index_id], [i].[name], [p].[rows], [p].[data_compression_desc]
ORDER BY [o].[name], [i].[index_id];
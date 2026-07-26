DECLARE
	@Code INT,
	@Message VARCHAR(255),
	@PageNumber INT,
	@PageSize INT,
	@TotalRows INT

EXEC [SQM_GENERAL].[USP_Products]
@i_pageNumber = 1,
@o_code = @Code OUT,
@o_message = @Message OUT,
@o_pageNumber = @PageNumber OUT,
@o_pageSize = @PageSize OUT,
@o_totalRows = @TotalRows OUT

PRINT 'CODIGO - ' +  TRY_CAST(@Code AS VARCHAR)
PRINT 'MENSAJE - ' + TRY_CAST(@Message AS VARCHAR)
PRINT 'NUMERO PAGINA - ' + TRY_CAST(@PageNumber AS VARCHAR)
PRINT 'TAMAÑO DE PAGINA - ' + TRY_CAST(@PageSize AS VARCHAR)
PRINT 'TOTAL REGISTROS - ' + TRY_CAST(@TotalRows AS VARCHAR)

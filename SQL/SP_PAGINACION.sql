CREATE OR ALTER PROC [SQM_GENERAL].[USP_Products]
(
	@i_pageNumber INT = NULL,
	@o_code INT = NULL OUTPUT,
	@o_message VARCHAR(255) = NULL OUTPUT,
	@o_pageNumber INT = NULL OUTPUT,
	@o_pageSize INT = NULL OUTPUT,
	@o_totalRows INT = NULL OUTPUT
)
AS
BEGIN
	DECLARE
		@RowsPerPage INT;
	SET @RowsPerPage = 10;

	BEGIN TRY
		-- Datos paginados
		SELECT GP.*
		FROM [SQM_GENERAL].[VW_GENERAL_PRODUCTS] AS GP
		--WHERE
		ORDER BY GP.ProductID, GP.ProviderID DESC
		OFFSET (@i_pageNumber - 1) * @RowsPerPage ROWS
		FETCH NEXT @RowsPerPage ROWS ONLY;
		
		-- Metadatos de paginación (OUTPUT)
		SELECT 
			@o_pageNumber = @i_pageNumber,
			@o_pageSize = @@ROWCOUNT,
			@o_totalRows = COUNT(1)
		FROM [SQM_GENERAL].[VW_GENERAL_PRODUCTS];

		IF (@o_pageSize > 0)
			BEGIN
				SET @o_code = 200
				SET @o_message = 'Carga de productos satisfactorio'
			END
		ELSE
			BEGIN
				SET @o_code = 204
				SET @o_message = 'Carga de productos satisfactoria pero ya no hay mas filas'
			END
	END TRY
	BEGIN CATCH
		SET @o_code = 500;
		SET @o_message = CONCAT_WS(' ','Error interno',ERROR_MESSAGE())
	END CATCH
END
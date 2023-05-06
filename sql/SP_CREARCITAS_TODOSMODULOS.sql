CREATE PROCEDURE SP_CREARCITAS_TODOSMODULOS

--ALTER PROCEDURE SP_CREARCITAS_TODOSMODULOS
@fecha date

AS

------------------------     Citas para todos los módulos existentes   ----------------------------------

-- Crear CURSOR
-- CURSOR: elemento que representará a un conjunto de datos determinado por una consulta T-SQL. 
-- Los cursores permiten recorrer fila a fila, leer y eventualmente modificar dicho conjunto de resultados.

-- declare @fecha date ='2023-05-04'
DECLARE @clavesModulo int

DECLARE ProdInfo CURSOR FOR SELECT id_modulo FROM modulo

OPEN ProdInfo
FETCH NEXT FROM ProdInfo INTO @clavesModulo
WHILE @@fetch_status = 0
BEGIN
    --PRINT @clavesModulo    -- MUESTRA EN DATOS EN CONSOLA
	SELECT @clavesModulo     -- muestra en Tabla

	EXEC SP_crearCitas @clavesModulo, @fecha

    FETCH NEXT FROM ProdInfo INTO @clavesModulo
END
CLOSE ProdInfo
DEALLOCATE ProdInfo     -- desalojar el Cursor

GO
/*
EXEC SP_crearCitas_todosModulos '2023-05-09'

SELECT * from citas where fecha='2023-05-08'
*/

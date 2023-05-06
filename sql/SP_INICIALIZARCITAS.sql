CREATE PROCEDURE SP_INICIALIZARCITAS  
--ALTER  PROCEDURE SP_INICIALIZARCITAS

AS
	-- oBTENER EL NÚMERO DEL DÍA DE LA SEMANA

	-- SELECT DATEPART(WEEKDAY,GETDATE())
	-- SELECT GETDATE()

	declare @fecha_inicio date=GETDATE()
	declare @numeroDia date
	declare @cont int=1
	while (@cont <= 60)
		begin
			--select @num
			set @numeroDia=DATEADD(DAY,@cont,@fecha_inicio)		-- asignamos numero de día
			-- SELECT DATEPART(WEEKDAY,@numeroDia)		-- WEEKDAY=DW, obtiene el numero del dia de la semana

			if(DATEPART(WEEKDAY,@numeroDia)>1 AND DATEPART(WEEKDAY,@numeroDia)<7)
				BEGIN
					-- SELECT 'DÍA LABORAL'
					EXEC SP_crearCitas_todosModulos @numeroDia		--  SP para crear todos los mudulos y sus citas en 60 días. Manda sólo dias laborales
				END
			set @cont=@cont+1
			-- set @hora_inicio=DATEADD(minute,12,@hora_inicio)   -- sumar 12 min a la hora_inicio y se asigna a set hora_inicio
		end
/*
GO
exec SP_INICIALIZARCITAS
select count(*) from citas
delete from citas	
*/

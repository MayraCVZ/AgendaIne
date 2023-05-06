CREATE PROCEDURE SP_CREARCITAS    -- SOLO PARA CREAR PROCEDURE

--ALTER PROCEDURE SP_CREARCITAS  -- ALTER es para hacer cambios en el código del Procedure, si se usa Create marca error porque ya está creado
		-- marca línea roja porque el Query quiere ejecutar todo el código comentado
		-- sobrecarga de variables (se agregan en el EXECUTE)
	@modulo int,
	@fecha date

AS
	--declare @modulo int = 160551    -- ya están en sobrecarga
	declare @folio int = 0
	--declare @fecha date = '2023-05-03'
	declare @hora_inicio time
	declare @hora_termino time
	declare @duracion int
	declare @numero_citas int
	declare @citas_existentes int

	-- validar que no haya citas en un día
	--select * from citas where id_modulo=@modulo and fecha=@fecha
	--select COUNT(*) from citas where id_modulo=@modulo and fecha=@fecha		-- num citas existentes

	-- asignar num filas a @citas_existentes VALIDAMOS que no se puedan seguir creando citas en una misma fecha
	select @citas_existentes=COUNT(*) from citas where id_modulo=@modulo and fecha=@fecha
	if (@citas_existentes>0)
		begin
			select 'Ya existen citas programadas para esta fecha'
		end
			else
				begin
				select @folio=ISNULL(MAX(folio),0) from citas
					--select * from modulo where id_modulo=@modulo
					-- citas para el módulo, asignación
					select @hora_inicio=hora_inicio, @hora_termino=hora_termino from modulo where id_modulo=@modulo

					-- calcular duracion jornada
					-- select DATEDIFF(HOUR,'08:00','15:00')

					-- Número de citas
					set @numero_citas = 5 * DATEDIFF(HOUR,@hora_inicio,@hora_termino)
					-- select @numero_citas

					-- generar número de citas con un ciclo While
					declare @num int=1
					while (@num <= @numero_citas)
						begin
							--select @num
							set @num=@num+1
							set @folio=@folio+1
							insert into citas values(@modulo,@folio,@fecha,@hora_inicio,'Disponible');
							set @hora_inicio=DATEADD(minute,12,@hora_inicio)   -- sumar 12 min a la hora_inicio y se asigna a set hora_inicio
						end

					select concat('se crearon ', @numero_Citas, ' citas')

				end   -- fin del IF

/*
select * from citas where fecha='2023-05-04' order by hora

EXEC SP_CREARCITAS 160551,'2023-05-09'			-- marca línea roja porque el Query quiere ejecutar todo el código comentado
*/

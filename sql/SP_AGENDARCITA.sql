CREATE PROCEDURE SP_AGENDARCITA  
--ALTER PROCEDURE SP_AGENDARCITA  
	@folio int,
	@idUsuario int,
	@idTramite int,
	@idDoc1 int,
	@idDoc2 int,
	@idDoc3 int

AS
DECLARE @cita_disponible int
BEGIN
	select @cita_disponible = COUNT(*) from citas where folio=@folio and estado <> 'Disponible'
	IF (@cita_disponible>0)
		BEGIN
			select 'Horario no disponible'
		END
	ELSE
		BEGIN
			select @cita_disponible = COUNT(*) FROM detalle_cita dc, citas c where c.folio = dc.folio and dc.id_usuario=1 and c.fecha > GETDATE()
			IF (@cita_disponible>0)
				BEGIN
					select 'Ya existe una cita agendada'
				END
			ELSE	
				BEGIN
					BEGIN TRANSACTION
						BEGIN TRY
							insert into detalle_cita values(@folio,@idUsuario,@idTramite,@idDoc1,@idDoc2,@idDoc3);
							update citas set estado='Reservado' where folio=@folio
							--set @hora_inicio=DATEADD(minute,12,@hora_inicio)   -- sumar 12 min a la hora_inicio y se asigna a set hora_inicio
							select concat('Cita agendada, numero de folio: ',@folio )
					COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
					ROLLBACK TRANSACTION
						PRINT 'Error en la operacion'+error_message() ; 
					END CATCH
				END
		END
END
	  
/*
EXEC SP_AGENDARCITA 1,1,1,1,4,26	  


SELECT * FROM estados
select * from municipio
SELECT mo.*,mu.nombre FROM modulo mo , municipio mu where mo.id_municipio= mu.id_municipio
select * from usuarios --1
SELECT * FROM citas where estado = 'Disponible'  --1
select * from tramite -1
select * from categoria
/*
1	Documento de nacionalidad
2	Documento de identidad con fotografía:
3	Comprobante de domicilio:
*/
select * from documento where id_categoria=1  --1
select * from documento where id_categoria=2  --4
select * from documento where id_categoria=3  --26
SELECT * FROM detalle_cita dc, citas c where c.folio=dc.folio and dc.id_usuario=1 and dc.folio=1
and c.fecha > GETDATE()

--delete detalle_cita
--update citas set estado='Disponible'
select count(*) FROM detalle_cita dc, citas c where c.folio = dc.folio and dc.id_usuario=2 and c.fecha > GETDATE()
*/

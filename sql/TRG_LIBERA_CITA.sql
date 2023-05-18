use citas_ine
go

CREATE TRIGGER TRG_LIBERA_CITA  
ON detalle_cita 
AFTER DELETE   
AS 
DECLARE 
@folio int
begin
	SELECT @folio=folio FROM deleted 
	update citas set estado='Disponible' where @folio=folio
end
GO  

/*
select * FROM detalle_cita;
select * from citas where estado <>'Disponible';
delete from detalle_cita where folio=1;
*/
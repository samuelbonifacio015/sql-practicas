USE VIDA_SANA
GO

exec sp_helptext sp_ins_espec_med

/* Ejempo: Creacion de procedure */
ALTER PROCEDURE SP_INS_ESPEC_MED
@id_especialidad INT,
@nombre TEXT
AS
BEGIN TRAN T_INS_ESPEC_MED
    INSERT INTO especialidad(id_especialidad, nombre)
	VALUES (@id_especialidad, @nombre)

    IF @@ERROR = 0  
    BEGIN
         COMMIT TRAN T_INS_ESP_MED
		 PRINT 'ESPECIALIDAD INGRESADA CORRECTAMENTE'
    END
	ELSE
	BEGIN
		 ROLLBACK 
		 PRINT 'CORRIJA ERRORES'
	END

--Prueba de SP
EXEC SP_INS_ESPEC_MED '8', 'PSICOLOGIA'

SELECT * FROM especialidad


--TRIGGERS (DISPARADORES)

--crear una tabla de auditoria cuando se quiere insertar una especialidad

CREATE TABLE AUDITORIA_ESPE_MED
(
id_aud_esp int identity(1,1) primary key,
id_especialidad int,
nombre nvarchar(100),
fecha date,
usuario nvarchar(100)
)

--TRIGGERS

--crear un trigger que registre los datos de la tabla especialidad medica cuando alguien inserta datos
CREATE TRIGGER TR_INS_ESP_AUD 
ON ESPECIALIDAD
FOR INSERT
AS
BEGIN
    INSERT INTO AUDITORIA_ESPE_MED(id_especialidad, nombre, fecha, usuario)
    SELECT ID_ESPECIALIDAD, NOMBRE, GETDATE(), 'JUAN PEREZ'
    FROM inserted;
END;

--cambiar el tipo de dato
alter table especialidad
alter column nombre nvarchar(100)

select id_especialidad, nombre from especialidad

SELECT * FROM AUDITORIA_ESPE_MED




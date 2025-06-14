use VidaSana

select*from medico

use VIDA_SANA

--CREAR PROCEDIMIENTOS ALMACENADOS

create procedure SP_LIS_ESPEC_MED
AS
SELECT*FROM especialidad

--LLAMAR A UN SP

EXEC SP_LIS_ESPEC_MED

--CREAR UN SP PARA INSERTAR DATOS

CREATE PROCEDURE SP_INS_ESPEC_MED
@id_especialidad int,
@nombre text
AS
INSERT INTO especialidad(id_especialidad,nombre)
VALUES(@id_especialidad,@nombre)

--LLAMAR A UN SP

EXEC SP_INS_ESPEC_MED '3','Medicina Espacial'

--
SELECT*FROM especialidad

--CREAR UN SP PARA ELIMINAR DATOS

CREATE PROCEDURE SP_DEL_ESPEC_MED
@id_especialidad int,

AS
DELETE FROM especialidad


--crear los procedimientos almacenados de insertar, actualizar y eliminar un medico
select*from medico
insert into medico values (
'1','Jefferson','Castro Pariona','2','0546','548874875','u26548@upc.edu.pe'
)

CREATE PROCEDURE SP_INS_DAT_MED
@id_med int,
@nombre text,
@apellidos text,
@espec_id varchar,
@num_coleg varchar,
@telefono varchar,
@correo varchar
AS
INSERT INTO medico(id_medico,nombres,apellidos,especialidad_id,num_colegiatura,telefono,correo_institucional)
VALUES(@id_med,@nombre,@apellidos,@espec_id,@num_coleg,@telefono,@correo)

--LLAMAR A UN SP

EXEC SP_INS_DAT_MED '2','Gianella Carolina','Tello Gonzales','1','24154','941448745','u26846@upc.edu.pe'
select * from medico

CREATE PROCEDURE SP_UPD1_DAT_MED
@id_med int,
@nombre text,
@apellidos text,
@espec_id varchar(10),
@num_coleg varchar(10),
@telefono varchar(9),
@correo varchar(30)
AS
update medico set id_medico=@id_med,
nombres=@nombre,
apellidos=@apellidos,
especialidad_id=@espec_id,
num_colegiatura=@num_coleg,
telefono=@telefono,
correo_institucional=@correo
where id_medico=@id_med
EXEC SP_UPD1_DAT_MED 2, 'Gianella Carolina', 'Tello Gonzales', '1', '24154', '941448745', 'u26846@upc.edu.pe';

select * from medico



--actualizar la tabla MEDICO con el atributo id_direccion y colocarlo con llave foranea
alter table medico add id_direccion int
ALTER TABLE medico
ADD CONSTRAINT FK_Medico_Direccion
FOREIGN KEY (id_direccion)
REFERENCES direccion(id_direccion);

--luego insertar 10 direcciones con ubigeos diferentes 

--finalmente insertar o actualizar 5 medicos con las direcciones creadas


insert into especialidad(id_especialidad,nombre)
values (@id_especialidad,@nombre)


select*from especialidad



exec SP_INS_ESPEC_MED '6','MEDICINA GENERAL'

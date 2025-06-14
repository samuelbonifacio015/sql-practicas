use TALKS

select*from Alumno
select*from Docente
select*from Universidad
select*from Ciudad
select*from Grado_Academico
select*from Grupo_revisor
select*from propuesta_charla

insert into Ciudad values
(1,'Lima'),
(2,'San Lorenzo'),
(3,'San Bartolome'),
(4,'Peru Libre'),
(5,'Chabuca Granda')

insert into Universidad values
(1,2,'Cesar Vallejo'),
(2,1,'Ricardo Palma'),
(3,3,'Bausate y Meza'),
(4,5,'UPN'),
(5,4,'PUCP')

insert into Grado_Academico values
(1,'Doctor'),
(2,'Magister')

insert into Grupo_revisor values
(1, 'Grupo 1'),
(2, 'Grupo 2'),
(3, 'Grupo 3'),
(4, 'Grupo 4'),
(5, 'Grupo 5')

insert into Docente values
(1,3,4,1,'Luz Vilma','Jimenez Alegre',40),
(2,1,2,1,'Maria Graciela','Tello Cardenas',50),
(3,4,3,1,'Ricardo Martin','Alvarez Cossio',55),
(4,2,4,1,'Sofia Fernanda','Sanchez Madrid',60),
(5,5,1,1,'Alvaro Gonzalo','Montoya Prado',52)
UPDATE Docente
SET Edad = 40
WHERE ID_docente = 1;

UPDATE Docente
SET Edad = 50
WHERE ID_docente = 2;

UPDATE Docente
SET Edad = 55
WHERE ID_docente = 3;

UPDATE Docente
SET Edad = 60
WHERE ID_docente = 4;

UPDATE Docente
SET Edad = 52
WHERE ID_docente = 5;

select*from Propuesta_charla

insert into Propuesta_charla values
(1,3,2,'A','Programacion ATS','Orientado a crear aplicaciones en beneficio de la humanidad'),
(2,3,1,'A','JAVA','Java for benginners'),
(3,3,4,'A','PYTHON','Centrado a la elaboración de proyectos'),
(4,2,5,'A','IOT','Internet de las cosas'),
(5,1,3,'A','ALGORITMOS','Algoritmos y Estructura de datos, planteamiento de ejercicios')

--asasas

INSERT INTO Alumno (ID_Alumno, DNI, Nombres, Apellidos)
VALUES 
(1, '12345678', 'Juan', 'Pérez'),
(2, '87654321', 'María', 'López'),
(3, '23456789', 'Carlos', 'González'),
(4, '34567890', 'Ana', 'Martínez'),
(5, '45678901', 'Luis', 'Ramírez');

INSERT INTO Cat_Charla_aceptada (ID_Cat_Charla_aceptada, Categoria)
VALUES
(1, 'Tecnología'),
(2, 'Ciencias'),
(3, 'Arte');


-- Insertar charla aceptada (programación de la charla)
INSERT INTO Charla_aceptada (ID_Charla_aceptada, ID_Propuesta_Charla, ID_Cat_Charla_aceptada, Fecha, Hora, Duracion, Capacidad)
VALUES (1, 1, 2, '2025-06-01', '10:00:00', '01:00', '50');

-- Insertar alumnos inscritos en la charla aceptada
INSERT INTO Inscripcion_Charla (ID_Charla_aceptada, ID_Alumno, asistencia)
VALUES (1, 1, 1),  -- Alumno 101 inscrito
       (1, 2, 0) 
      


--Mostrar el nombre de la universidad con la mayor cantidad de propuestas recibidas. 

SELECT
    u.Nombre AS Nombre_Universidad,
    COUNT(p.ID_Propuesta_Charla) AS CantidadPropuestas
FROM
    Propuesta_Charla p
JOIN
    Docente d ON p.ID_docente = d.ID_docente
JOIN
    Universidad u ON d.ID_Uni = u.ID_Uni
GROUP BY
    u.Nombre
HAVING
    COUNT(p.ID_Propuesta_Charla) = (
        SELECT MAX(Conteo)
        FROM (
            SELECT
                COUNT(p2.ID_Propuesta_Charla) AS Conteo
            FROM
                Propuesta_Charla p2
            JOIN
                Docente d2 ON p2.ID_docente = d2.ID_docente
            JOIN
                Universidad u2 ON d2.ID_Uni = u2.ID_Uni
            GROUP BY
                u2.Nombre
        ) AS Subconteo
    );


-- Mostrar el nombre de la charla con la mayor cantidad de alumnos inscritos. 

select*from Inscripcion_Charla

SELECT 
    pc.Nombre_charla,
    COUNT(ic.ID_Alumno) AS CantidadAlumnos
FROM 
    Inscripcion_Charla ic
JOIN 
    Charla_aceptada ca ON ic.ID_Charla_aceptada = ca.ID_Charla_aceptada
JOIN
    Propuesta_Charla pc ON ca.ID_Propuesta_Charla = pc.ID_Propuesta_Charla
GROUP BY 
    pc.Nombre_charla
HAVING 
    COUNT(ic.ID_Alumno) = (
        SELECT MAX(Cantidad)
        FROM (
            SELECT COUNT(ID_Alumno) AS Cantidad
            FROM Inscripcion_Charla ic2
            GROUP BY ic2.ID_Charla_aceptada
        ) AS Conteo
    );






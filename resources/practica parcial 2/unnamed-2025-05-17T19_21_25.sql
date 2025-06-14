create database TALKS

USE TALKS

CREATE TABLE Alumno
(
  ID_Alumno INT  NOT NULL,
  DNI       CHAR NOT NULL,
  Nombres   TEXT NOT NULL,
  Apellidos TEXT NOT NULL,
  PRIMARY KEY (ID_Alumno)
);

CREATE TABLE Cat_Charla_aceptada
(
  ID_Cat_Charla_aceptada INT     NOT NULL,
  Categoria              VARCHAR NOT NULL,
  PRIMARY KEY (ID_Cat_Charla_aceptada)
);

CREATE TABLE Charla_aceptada
(
  ID_Charla_aceptada     INT  NOT NULL,
  ID_Propuesta_Charla    INT  NOT NULL,
  ID_Cat_Charla_aceptada INT  NOT NULL,
  Fecha                  DATE NOT NULL,
  Hora                   TIME NOT NULL,
  Duracion               CHAR NOT NULL,
  Capacidad              CHAR NOT NULL,
  PRIMARY KEY (ID_Charla_aceptada)
);

CREATE TABLE Ciudad
(
  ID_Ciudad INT  NOT NULL,
  Ciudad    TEXT NOT NULL,
  PRIMARY KEY (ID_Ciudad)
);

CREATE TABLE Docente
(
  ID_docente         INT  NOT NULL,
  ID_Grupo_revisor   INT  NOT NULL,
  ID_Uni             INT  NOT NULL,
  ID_Grado_Academico INT  NOT NULL,
  Nombres            TEXT NOT NULL,
  Apellidos          TEXT NOT NULL,
  Edad               CHAR NOT NULL,
  PRIMARY KEY (ID_docente)
);

CREATE TABLE Grado_Academico
(
  ID_Grado_Academico INT  NOT NULL,
  Grado_Academico    TEXT NOT NULL,
  PRIMARY KEY (ID_Grado_Academico)
);

CREATE TABLE Grupo_revisor
(
  ID_Grupo_revisor INT  NOT NULL,
  nombre           TEXT NOT NULL,
  PRIMARY KEY (ID_Grupo_revisor)
);

CREATE TABLE Inscripcion_Charla
(
  ID_Charla_aceptada INT NOT NULL,
  ID_Alumno          INT NOT NULL,
  asistencia         INT NOT NULL,
  PRIMARY KEY (ID_Charla_aceptada, ID_Alumno)
);

CREATE TABLE Propuesta_Charla
(
  ID_Propuesta_Charla INT     NOT NULL,
  ID_docente          INT     NOT NULL,
  ID_Grupo_revisor    INT     NOT NULL,
  Estado              VARCHAR NOT NULL,
  Nombre_charla       TEXT    NOT NULL,
  Descripcion         TEXT    NOT NULL,
  PRIMARY KEY (ID_Propuesta_Charla)
);

CREATE TABLE Universidad
(
  ID_Uni    INT  NOT NULL,
  ID_Ciudad INT  NOT NULL,
  Nombre    TEXT NOT NULL,
  PRIMARY KEY (ID_Uni)
);

ALTER TABLE Propuesta_Charla
  ADD CONSTRAINT FK_Docente_TO_Propuesta_Charla
    FOREIGN KEY (ID_docente)
    REFERENCES Docente (ID_docente);

ALTER TABLE Docente
  ADD CONSTRAINT FK_Grupo_revisor_TO_Docente
    FOREIGN KEY (ID_Grupo_revisor)
    REFERENCES Grupo_revisor (ID_Grupo_revisor);

ALTER TABLE Inscripcion_Charla
  ADD CONSTRAINT FK_Charla_aceptada_TO_Inscripcion_Charla
    FOREIGN KEY (ID_Charla_aceptada)
    REFERENCES Charla_aceptada (ID_Charla_aceptada);

ALTER TABLE Inscripcion_Charla
  ADD CONSTRAINT FK_Alumno_TO_Inscripcion_Charla
    FOREIGN KEY (ID_Alumno)
    REFERENCES Alumno (ID_Alumno);

ALTER TABLE Docente
  ADD CONSTRAINT FK_Universidad_TO_Docente
    FOREIGN KEY (ID_Uni)
    REFERENCES Universidad (ID_Uni);

ALTER TABLE Docente
  ADD CONSTRAINT FK_Grado_Academico_TO_Docente
    FOREIGN KEY (ID_Grado_Academico)
    REFERENCES Grado_Academico (ID_Grado_Academico);

ALTER TABLE Universidad
  ADD CONSTRAINT FK_Ciudad_TO_Universidad
    FOREIGN KEY (ID_Ciudad)
    REFERENCES Ciudad (ID_Ciudad);

ALTER TABLE Charla_aceptada
  ADD CONSTRAINT FK_Propuesta_Charla_TO_Charla_aceptada
    FOREIGN KEY (ID_Propuesta_Charla)
    REFERENCES Propuesta_Charla (ID_Propuesta_Charla);

ALTER TABLE Propuesta_Charla
  ADD CONSTRAINT FK_Grupo_revisor_TO_Propuesta_Charla
    FOREIGN KEY (ID_Grupo_revisor)
    REFERENCES Grupo_revisor (ID_Grupo_revisor);

ALTER TABLE Charla_aceptada
  ADD CONSTRAINT FK_Cat_Charla_aceptada_TO_Charla_aceptada
    FOREIGN KEY (ID_Cat_Charla_aceptada)
    REFERENCES Cat_Charla_aceptada (ID_Cat_Charla_aceptada);

ALTER TABLE Docente
ALTER COLUMN Edad CHAR(2);

ALTER TABLE Propuesta_Charla
ALTER COLUMN Nombre_charla NVARCHAR(MAX);


ALTER TABLE Alumno ALTER COLUMN Nombres VARCHAR(255);
ALTER TABLE Alumno ALTER COLUMN Apellidos VARCHAR(255);

ALTER TABLE Ciudad ALTER COLUMN Ciudad VARCHAR(255);

ALTER TABLE Docente ALTER COLUMN Nombres VARCHAR(255);
ALTER TABLE Docente ALTER COLUMN Apellidos VARCHAR(255);

ALTER TABLE Grado_Academico ALTER COLUMN Grado_Academico VARCHAR(255);

ALTER TABLE Grupo_revisor ALTER COLUMN nombre VARCHAR(255);

ALTER TABLE Propuesta_Charla ALTER COLUMN Nombre_charla VARCHAR(255);
ALTER TABLE Propuesta_Charla ALTER COLUMN Descripcion VARCHAR(255);

ALTER TABLE Universidad ALTER COLUMN Nombre VARCHAR(255);

ALTER TABLE Charla_aceptada
ALTER COLUMN Duracion CHAR(5);

ALTER TABLE Charla_aceptada
ALTER COLUMN Capacidad CHAR(5);

ALTER TABLE Cat_Charla_aceptada
ALTER COLUMN Categoria VARCHAR(255);

ALTER TABLE Alumno
ALTER COLUMN DNI VARCHAR(8);
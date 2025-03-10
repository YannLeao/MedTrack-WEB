CREATE TABLE usuarios
(
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    tipo_conta      VARCHAR(255),
    nome            VARCHAR(255),
    email           VARCHAR(255),
    senha_hashed    VARCHAR(255),
    data_nascimento date,
    nome_usuario    VARCHAR(255),
    numero_telefone VARCHAR(255),
    CONSTRAINT pk_usuarios PRIMARY KEY (id)
);

CREATE TABLE medicamentos
(
    id                 BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    nome               VARCHAR(255),
    principio_ativo    VARCHAR(255),
    dosagem            VARCHAR(255)                       NOT NULL,
    observacoes        VARCHAR(255),
    usuario_id         BIGINT,
    dependente_id      BIGINT,
    frequencia_uso_id  BIGINT                                  NOT NULL,
    CONSTRAINT pk_medicamentos PRIMARY KEY (id)
);

CREATE TABLE frequencia_uso
(
    id                  BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    frequencia_uso_tipo VARCHAR(255),
    uso_continuo        BOOLEAN                                 NOT NULL,
    intervalo_horas     INTEGER                                 NOT NULL,
    primeiro_horario    time WITHOUT TIME ZONE,
    data_inicio         date,
    data_termino        date,
    CONSTRAINT pk_frequencia_uso PRIMARY KEY (id)
);

CREATE TABLE frequencia_uso_dias_semana
(
    frequencia_uso_id BIGINT NOT NULL,
    dias_semana       VARCHAR(255)
);

CREATE TABLE frequencia_uso_horarios_especificos
(
    frequencia_uso_id    BIGINT NOT NULL,
    horarios_especificos time WITHOUT TIME ZONE
);

ALTER TABLE medicamentos
    ADD CONSTRAINT FK_MEDICAMENTOS_ON_USUARIO FOREIGN KEY (usuario_id) REFERENCES usuarios (id);

ALTER TABLE medicamentos
    ADD CONSTRAINT FK_MEDICAMENTOS_ON_FREQUENCIA_USO FOREIGN KEY (frequencia_uso_id) REFERENCES frequencia_uso (id);

ALTER TABLE medicamentos
    ADD CONSTRAINT uc_medicamentos_frequencia_uso UNIQUE (frequencia_uso_id);

ALTER TABLE frequencia_uso_dias_semana
    ADD CONSTRAINT fk_frequenciauso_diassemana_on_frequencia_uso FOREIGN KEY (frequencia_uso_id) REFERENCES frequencia_uso (id);

ALTER TABLE frequencia_uso_horarios_especificos
    ADD CONSTRAINT fk_frequenciauso_horariosespecificos_on_frequencia_uso FOREIGN KEY (frequencia_uso_id) REFERENCES frequencia_uso (id);

CREATE TABLE dependentes
(
    id               BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    nome             VARCHAR(255),
    email            VARCHAR(255),
    telefone         VARCHAR(255),
    administrador_id BIGINT                                  NOT NULL,
    CONSTRAINT pk_dependentes PRIMARY KEY (id)
);

ALTER TABLE dependentes
    ADD CONSTRAINT FK_DEPENDENTES_ON_ADMINISTRADOR FOREIGN KEY (administrador_id) REFERENCES usuarios (id);

ALTER TABLE medicamentos
    ADD CONSTRAINT FK_MEDICAMENTOS_ON_DEPENDENTE FOREIGN KEY (dependente_id) REFERENCES dependentes (id);
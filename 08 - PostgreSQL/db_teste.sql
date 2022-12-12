CREATE TABLE IF NOT EXISTS public.data_dictionary (
    dd_id SERIAL PRIMARY KEY, -- Id de identificação do registro.
    dd_schema VARCHAR(50) NOT NULL, -- Identificação do Schema ao qual a tabela pertence.
    dd_table VARCHAR(50) NOT NULL, -- Identificação da Tabela ao qual o campo pertence.
    dd_column VARCHAR(50) NOT NULL, -- Nome do campo.
    dd_type VARCHAR(100) NOT NULL, -- Tipo do campo.
    dd_size INTEGER NOT NULL, -- Tamanho do campo. Observação: Quando o tipo for diferente de Varchar, o valor será 0.
    dd_specifications VARCHAR(200) NOT NULL, -- Especificações do campo. Exemplo: Primary Key, NOT NULL, UNIQUE, etc.
    dd_note VARCHAR(1000) NOT NULL -- Informações pertinentes ao campo. Normalmente se encontra comentado ao lado de cada campo.
);

CREATE TABLE IF NOT EXISTS public.origem_dados (
	od_id SERIAL NOT NULL PRIMARY KEY, -- Identificador do local de origem dos dados.
	od_local VARCHAR(20) NOT NULL, -- Local de origem do dados, exemplo: Planilha, API, etc.
	od_observacao VARCHAR(1000) -- Observações pertinentes sobre o local, um exemplo seria nome do arquivo de origem.
);

CREATE TABLE IF NOT EXISTS public.tipo_veiculo (
    tv_id SERIAL NOT NULL PRIMARY KEY, -- Id de Identificação do tipo de veiculo.
    tv_tipo VARCHAR(50) NOT NULL, -- Tipo do veiculo.
    tv_observacoes VARCHAR(1000) -- Observações sobre o tipo do veiculo.
);

CREATE TABLE IF NOT EXISTS public.marca_veiculo(
    mv_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação da marca do veiculo.
    mv_marca VARCHAR(30) NOT NULL, -- Marca do veiculo.
    mv_observacoes VARCHAR(1000) -- Observações sobre a marca do veiculo.
);

CREATE TABLE IF NOT EXISTS public.modelo_veiculo (
    mov_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação do modelo do veiculo.
    mov_modelo VARCHAR(30) NOT NULL, -- Modelo do veiculo.
    mov_observacoes VARCHAR(1000) -- Observações sobre o modelo do veiculo.
);

CREATE TABLE IF NOT EXISTS public.cor_veiculo (
    cv_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação da cor do veiculo
    cv_cor VARCHAR(30) NOT NULL, -- Cor predominate do veiculo.
    cv_observacoes VARCHAR(1000) -- Observações sobre a cor do veiculo.
);

CREATE TABLE IF NOT EXISTS public.municipio (
    mu_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação do municipio.
    mu_nome VARCHAR(100) NOT NULL, -- Nome do município.
    mu_uf VARCHAR(2) NOT NULL, -- Unidade Federativa ao qual o Município Pertence.
    mu_observacao VARCHAR(1000) -- Observações quanto ao município.
);

CREATE TABLE IF NOT EXISTS public.tipo_restricao (
    tr_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação do tipo de restrição
    tr_tipo VARCHAR(30) NOT NULL, -- Tipo de restrição. Exemplo: Busca e Apreensão.
    tr_observacao VARCHAR(1000) -- Observação do tipo de restrição.
);

CREATE TABLE IF NOT EXISTS public.tipo_ocorrencia (
    to_id BIGSERIAL NOT NULL PRIMARY KEY, -- Id de identificação do tipo de ocorrência.
    to_codigo VARCHAR(10) NOT NULL, -- Código de identificação do tipo de Ocorrência. Observação: Esse campo foi baseado no campo disponivel pela CELEPAR.
    to_tipo VARCHAR(20) NOT NULL, -- Tipo de ocorrência.
    to_observacao VARCHAR(1000) -- Observação do tipo de ocorrência.
);

CREATE TABLE IF NOT EXISTS public.tipo_notificacao (
    tn_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação no sistema do tipo de notificação.
    tn_tipo VARCHAR(20) NOT NULL, -- Tipo de notificação.
    tn_observacao VARCHAR(1000) -- Observação sobre tipo de notificação.
);

CREATE TABLE IF NOT EXISTS sc_alertas.dados_veiculo (
    dv_geo_id BIGSERIAL NOT NULL PRIMARY KEY, -- Geo Id de identificação do veiculo.
    dv_placa VARCHAR(7) NOT NULL UNIQUE, -- Placa do veiculo. Observação: Aceitara os modelos AAA9A99 (Modelo Mercosul) e AAA5678 (Modelo antigo brasileiro).  
    dv_renavam VARCHAR(13) NOT NULL UNIQUE, -- Renavam do veiculo.
    dv_numero_ocorrencias INTEGER NOT NULL, -- Número de ocorrências de comprote do veículo.
    dv_ultima_atualizacao DATE NOT NULL DEFAULT now(), -- Data da ultima atualização de dados vinculado ao veículo.
    dv_descricao_atualizacao VARCHAR(1000), -- Descrição da ultima atualização de dados vinculado ao veículo.
    dv_pontos_criticidade INTEGER NOT NULL DEFAULT 0, -- Pontos de criticidade do veículo. Observação: Esse ponto é definido baseado em uma série de regras e calculado por um IA.
    dv_status VARCHAR(100) NOT NULL, -- Status do veículo.
    tv_id INT NOT NULL, -- Identificador do Tipo de Veiculo.
    cv_id INT NOT NULL, -- Identificador da Cor do veiculo. Observação: Pode existir mais de uma cor em um veiculo, nesse caso seria a cor predominante, ou cores fantasias, adesivados, etc.
    mv_id INT NOT NULL, -- Identificador da Marca do Veiculo.
    mov_id INT NOT NULL, -- Identifica o Modelo do veiculo.
    mu_id INT NOT NULL, -- Identificador do municipio ao qual o veículo está associado.
    od_id INT NOT NULL, -- Identificação do local de importação do dado (Se foi importada de planilha, API's ou via sistema).
    FOREIGN KEY (tv_id) REFERENCES public.tipo_veiculo(tv_id),
    FOREIGN KEY (mv_id) REFERENCES public.marca_veiculo(mv_id),
    FOREIGN KEY (mov_id) REFERENCES public.modelo_veiculo(mov_id),
    FOREIGN KEY (cv_id) REFERENCES public.cor_veiculo(cv_id),
    FOREIGN KEY (mu_id) REFERENCES public.municipio(mu_id),
    FOREIGN KEY (od_id) REFERENCES public.origem_dados(od_id)
);

CREATE TABLE IF NOT EXISTS sc_alertas.dados_camera (
    dc_id SERIAL NOT NULL PRIMARY KEY, -- Id de identificação da câmera no sistema.
    dc_codigo VARCHAR(50) NOT NULL UNIQUE, -- Codigo de identificação da câmera.
    dc_identificador VARCHAR(100) NOT NULL, -- Identificador da camera. Observação: Diferente de ID, esse identificador é a nomenclatura dada à câmera. 
    dc_latitude DOUBLE PRECISION NOT NULL, -- Latitude de georreferenciamento da localização da câmera.
    dc_longitude DOUBLE PRECISION NOT NULL, -- Longitude de georreferenciamento da localização da câmera.
    dc_localizacao GEOMETRY(POINT), -- Campo GEOMETRY do PostGis, para apresentação quartesiana da geolocalização da câmera. Observação: Utiliza a Latitude e Longitude.
    dc_sentido VARCHAR(20) NOT NULL, -- Identificação do sentido ao qual a câmera está apontada.
    dc_data_cadastro TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), -- Data de quando o cadastro foi realizado.
    dc_ativa BOOLEAN NOT NULL DEFAULT true, -- Identificação se a câmera continua ativa.
    dc_observacao VARCHAR(1000), -- Informações adicionais sobre a câmera.
    od_id INT NOT NULL, -- Identificação do local de importação do dado (Se foi importada de planilha, API's ou via sistema).
    FOREIGN KEY (od_id) REFERENCES public.origem_dados(od_id)
);

CREATE TABLE IF NOT EXISTS sc_alertas.notificacao (
    no_id BIGSERIAL NOT NULL PRIMARY KEY, -- ID de Identificação do registro no sistema.
    no_latitude DOUBLE PRECISION NOT NULL, -- Latitude de georreferenciamento da localização da notificação.
    no_longitude DOUBLE PRECISION NOT NULL, -- Longitude de georreferenciamento da localização da notificação.
    no_localizacao GEOMETRY(POINT), -- Campo GEOMETRY do PostGis, para apresentação quartesiana da geolocalização da notificação. Observação: Utiliza a Latitude e Longitude.
    no_origem_notificacao VARCHAR(20), -- Identifica a origem da notificação. Exemplo: Agente, Câmera, etc.
    no_observacao VARCHAR(1000), -- Observação da notificação.
    no_hora TIME NOT NULL DEFAULT now(), -- Horário de emissão da notificação.
    no_data DATE NOT NULL DEFAULT now(), -- Data de emissão da notificação.
    no_ativa BOOLEAN NOT NULL DEFAULT true, -- Status da notificação.
    nc_status_visualizacao INTEGER NOT NULL DEFAULT 0, -- Identifica o status de visualização da notificação. Observação: 0 - Notificação não lida, 1 - Notificação apenas visualizada no painel de notificação, 2 - Notificação lida.
    ag_id_visualizacao INTEGER, -- Agente que visualizou a notificação no sistema.
    ag_id INTEGER, -- Id de identificação do agente emitente da notificação.
    dc_id INTEGER, -- Id de identificação da camera emitente da notificação.
    tn_id INTEGER NOT NULL, -- Id de identificação do tipo de notificação.
    od_id INT NOT NULL, -- Identificação do local de importação do dado (Se foi importada de planilha, API's ou via sistema).
    FOREIGN KEY (ag_id) REFERENCES sc_alertas.agentes(ag_id),
    FOREIGN KEY (dc_id) REFERENCES sc_alertas.dados_camera(dc_id),
    FOREIGN KEY (tn_id) REFERENCES public.tipo_notificacao(tn_id),
    FOREIGN KEY (od_id) REFERENCES public.origem_dados(od_id)
);

CREATE TABLE IF NOT EXISTS sc_alertas.imagem_notificacao (
    in_id BIGSERIAL NOT NULL PRIMARY KEY, -- Id de identificação do registro no sistema.
    in_imagem BYTEA NOT NULL, -- Imagem armazenada em modo BYTEA.
    no_id BIGINT NOT NULL, -- Id de identificação da notificação ao qual a imagem está associada.
    FOREIGN KEY (no_id) REFERENCES sc_alertas.notificacao(no_id)
);

CREATE TABLE IF NOT EXISTS sc_alertas.lista_notificacoes_ativas (
    no_id BIGINT NOT NULL PRIMARY KEY, -- Id de identificação da notificação será usada como Primary Key desta Tabela. Observação: A tabela lista_notificacoes_ativas será populada apenas por Trigger, sendo usada apenas para consultas.
    lna_latitude DOUBLE PRECISION NOT NULL, -- Latitude de georreferenciamento da localização da notificação.
    lna_longitude DOUBLE PRECISION NOT NULL, -- Longitude de georreferenciamento da localização da notificação.
    lna_localizacao GEOMETRY(POINT) NOT NULL, -- Campo GEOMETRY do PostGis, para apresentação quartesiana da geolocalização da notificação. Observação: Utiliza a Latitude e Longitude.
    lna_camera BOOLEAN NOT NULL, -- Identifica se a notificação está associada a uma câmera.
    dc_id INTEGER, -- Id de identificação da câmera caso o registro esteja associado a uma.
    FOREIGN KEY (dc_id) REFERENCES sc_alertas.dados_camera(dc_id),
    FOREIGN KEY (no_id) REFERENCES sc_alertas.notificacao(no_id)
);
import apm from "elastic-apm-node";

apm.start({
  serviceName: process.env.ELASTIC_APM_SERVICE_NAME || "minha-api",
  secretToken: process.env.ELASTIC_APM_SECRET_TOKEN || "",
  serverUrl: process.env.ELASTIC_APM_SERVER_URL || "http://apm-server:9200",
  environment: process.env.NODE_ENV || "development",
  logLevel: "info",
});

// Agora importe os outros módulos
import { Client } from "@elastic/elasticsearch";
import express, { Request, Response } from "express";
import oracledb from "oracledb";

const app = express();
app.use(express.json());

const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  connectString: process.env.DB_CONNECT_STRING,
};

const elasticClient = new Client({
  node: process.env.ELASTICSEARCH_NODE || "http://elasticsearch:9200",
  auth: {
    username: process.env.ELASTIC_USER || "elastic",
    password: process.env.ELASTIC_PASSWORD || "teste123",
  },
});

app.get("/", async (req: Request, res: Response) => {
  res.status(200).send("Healthy");
});

app.post("/user", async (req: Request, res: Response) => {
  // Inicie uma transação APM para esta rota
  const transaction = apm.startTransaction("POST /user", "request");

  const { nome, idade, email } = req.body;

  if (!nome || !idade || !email) {
    res
      .status(400)
      .send(
        "Por favor, informe todos os campos necessários: nome, idade e email."
      );
    if (transaction) {
      transaction.result = "failure";
      transaction.end();
    }
    return;
  } 

  let conn;

  try {
    // Span para a conexão e inserção no OracleDB
    const spanOracle = transaction?.startSpan(
      "Insert no OracleDB",
      "db",
      "oracle",
      "query"
    );

    console.log("conectando no bando de dados");
    conn = await oracledb.getConnection(dbConfig);
    console.log("conexao ok, iniciando insert de dados");
    const sql = `INSERT INTO usuarios (nome, idade, email) VALUES (:nome, :idade, :email)`;
    const binds = { nome, idade, email };
    await conn.execute(sql, binds, { autoCommit: true });
    console.log("dados encerrados");

    if (spanOracle) {
      spanOracle.end();
    }

    // Span para a indexação no Elasticsearch
    const spanElastic = transaction?.startSpan(
      "Index no Elasticsearch",
      "db",
      "elasticsearch",
      "index"
    );

    await elasticClient.index({
      index: "users",
      body: {
        nome,
        idade,
        email,
      },
    });

    if (spanElastic) {
      spanElastic.end();
    }

    res
      .status(201)
      .send("Usuário foi inserido no OracleDB e no Elasticsearch.");

    if (transaction) {
      transaction.result = "success";
    }
  } catch (error: any) {
    console.error("Erro ao inserir usuário:", error);
    apm.captureError(error);
    res.status(500).send("Erro ao inserir usuário.");

    if (transaction) {
      transaction.result = "failure";
    }

    // Tentativa de rollback no OracleDB se necessário
    if (conn) {
      try {
        const spanRollback = transaction?.startSpan(
          "Rollback no OracleDB",
          "db",
          "oracle",
          "rollback"
        );

        await conn.execute(
          `DELETE FROM usuarios WHERE email = :email`,
          { email },
          { autoCommit: true }
        );

        if (spanRollback) {
          spanRollback.end();
        }
      } catch (rollbackError: any) {
        console.error("Erro ao fazer rollback no OracleDB:", rollbackError);
        apm.captureError(rollbackError);
      }
    }
  } finally {
    // Fechamento da conexão com o OracleDB
    if (conn) {
      try {
        await conn.close();
      } catch (closeError: any) {
        console.error("Erro ao fechar a conexão com o OracleDB:", closeError);
        apm.captureError(closeError);
      }
    }

    // Certifique-se de encerrar a transação APM
    if (transaction) {
      transaction.end();
    }
  }
});

// Iniciar o servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
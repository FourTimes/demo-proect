const express = require("express");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const morgan = require("morgan");
const helmet = require("helmet");
const db = require("./config/db");

const app = express();
app.use(express.json());
app.use(cookieParser());
app.use(morgan("combined"));
app.use(cors());
app.use(helmet());

const port = process.env.PORT || 4000;

app.get("/", (req, res) => res.send("Welcome to Helmet"));

app.get("/healthz", (req, res) =>
  res.send({
    status: res.statusCode,
    health: "ok",
  })
);

app.get("/data", (req, res) => {
  var query = "SELECT 1000 + 1 AS count";
  db.query(query, (error, results, fields) => {
    if (error) res.status(400).json({ success: false, message: error.code });
    res.send({
      success: true,
      count: results[0].count,
    });
  });
});

app.listen(port, () => {
  console.log(`listening at http://localhost:${port}`);
});

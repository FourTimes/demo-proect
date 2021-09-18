const mysql = require("mysql");

const config = {
  host: "localhost",
  user: "demo",
  password: "YourPwdShouldBeLongAndSecure!",
  database: "demo",
  dateStrings: true,
  debug: false
};

var readConnection = mysql.createPool(config);

module.exports = readConnection;


// CREATE USER 'demo'@'localhost' IDENTIFIED BY 'Password@123';
// GRANT ALL PRIVILEGES ON *.* TO 'demo'@'localhost';
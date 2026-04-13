'use strict';

const express = require('express');

const PORT = 8080;
const HOST = '0.0.0.0';

const app = express();

app.get('/', (_, res) => {
  res.json({
    message: "It's a CI/CD project!",
    status: 'ok',
  });
});

if (require.main === module) {
  app.listen(PORT, HOST, () => {
    console.log(`Running on http://${HOST}:${PORT}`);
  });
}

module.exports = app;

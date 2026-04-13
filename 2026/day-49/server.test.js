const request = require('supertest');
const app = require('./server');

describe('GET /', () => {
  it('should return a 200 status', async () => {
    const response = await request(app).get('/');
    expect(response.status).toBe(200);
  });

  it('should return the correct JSON body', async () => {
    const response = await request(app).get('/');
    expect(response.body).toEqual({
      message: "It's a CI/CD project!",
      status: 'ok',
    });
  });
});

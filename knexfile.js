module.exports = {
  development: {
    client: 'pg',  // Certifique-se de que está usando 'pg' para PostgreSQL
    connection: {
      host: '127.0.0.1',
      user: 'postgres',
      password: '205252',
      database: 'EducaLivros-Oline'
    },
    migrations: {
      directory: './migrations'
    },
    seeds: {
      directory: './seeds'
    }
  }
};

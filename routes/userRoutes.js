const Router = require('koa-router');
const db = require('../db');

const router = new Router();

router.get('/users', async (ctx) => {
  const users = await db('Usuario').select('*');
  ctx.body = users;
});


router.post('/', async (ctx) => {
  const { id_usuario, telefone, email, endereco, data_de_nascimento, cpf, nome, idade } = ctx.request.body;
  try {
    await db('usuario').insert({ id_usuario, telefone, email, endereco, data_de_nascimento, cpf, nome, idade });
    ctx.status = 201;
    ctx.body = { message: 'Usuário criado com sucesso!' };
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});


router.get('/', async (ctx) => {
  try {
    const users = await db('usuario').select('*');
    ctx.body = users;
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});


router.get('/:id', async (ctx) => {
  const { id } = ctx.params;
  try {
    const user = await db('usuario').where({ id_usuario: id }).first();
    if (user) {
      ctx.body = user;
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Usuário não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

router.put('/:id', async (ctx) => {
  const { id } = ctx.params;
  const { telefone, email, endereco, data_de_nascimento, cpf, nome, idade } = ctx.request.body;
  try {
    const updated = await db('usuario').where({ id_usuario: id }).update({ telefone, email, endereco, data_de_nascimento, cpf, nome, idade });
    if (updated) {
      ctx.body = { message: 'Usuário atualizado com sucesso' };
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Usuário não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

router.delete('/:id', async (ctx) => {
  const { id } = ctx.params;
  try {
    const deleted = await db('usuario').where({ id_usuario: id }).del();
    if (deleted) {
      ctx.body = { message: 'Usuário excluído com sucesso' };
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Usuário não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

module.exports = router;

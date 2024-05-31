const Router = require('koa-router');
const db = require('../db');

const router = new Router();

router.post('/', async (ctx) => {
  const { id_emprestimo, data_de_emprestimo, data_de_devolucao, id_livro, id_usuario } = ctx.request.body;
  try {
    await db('emprestimo').insert({ id_emprestimo, data_de_emprestimo, data_de_devolucao, id_livro, id_usuario });
    ctx.status = 201;
    ctx.body = { message: 'Empréstimo criado com sucesso' };
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});


router.get('/', async (ctx) => {
  try {
    const loans = await db('emprestimo').select('*');
    ctx.body = loans;
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

router.get('/:id', async (ctx) => {
  const { id } = ctx.params;
  try {
    const loan = await db('emprestimo').where({ id_emprestimo: id }).first();
    if (loan) {
      ctx.body = loan;
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Empréstimo não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

router.put('/:id', async (ctx) => {
  const { id } = ctx.params;
  const { data_de_emprestimo, data_de_devolucao } = ctx.request.body;
  try {
    const updated = await db('emprestimo').where({ id_emprestimo: id }).update({ data_de_emprestimo, data_de_devolucao });
    if (updated) {
      ctx.body = { message: 'Empréstimo atualizado com sucesso' };
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Empréstimo não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});


router.delete('/:id', async (ctx) => {
  const { id } = ctx.params;
  try {
    const deleted = await db('emprestimo').where({ id_emprestimo: id }).del();
    if (deleted) {
      ctx.body = { message: 'Empréstimo excluído com sucesso' };
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Empréstimo não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

module.exports = router;

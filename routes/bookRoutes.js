const Router = require('koa-router');
const db = require('../db');

const router = new Router();

// aqui serve para criar o livro
router.post('/', async (ctx) => {
  const { titulo, id_livro, sessao, numeros_de_pags, autor, ano, genero, numero } = ctx.request.body;
  try {
    await db('livro').insert({ titulo, id_livro, sessao, numeros_de_pags, autor, ano, genero, numero});
    ctx.status = 201;
    ctx.body = { message: 'Livro criado com sucesso!' };
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

// aqui serve para ver TODOS os livros
router.get('/', async (ctx) => {
  try {
    const books = await db('livro').select('*');
    ctx.body = books;
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

// aqui serve para ver UM LIVRO livro pelo seu ID
router.get('/:id', async (ctx) => {
  const { id } = ctx.params;
  try {
    const book = await db('livro').where({ id_livro: id }).first();
    if (book) {
      ctx.body = book;
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Livro não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

// aqui serve para atualizar os livros
router.put('/:id', async (ctx) => {
  const { id } = ctx.params;
  const { titulo, sessao, numeros_de_pags, autor, ano, genero, numero, fk_emprestimo_id_emprestimo, fk_editora_nome_editora } = ctx.request.body;
  try {
    const updated = await db('livro').where({ id_livro: id }).update({ titulo, sessao, numeros_de_pags, autor, ano, genero, numero, fk_emprestimo_id_emprestimo, fk_editora_nome_editora });
    if (updated) {
      ctx.body = { message: 'Livro atualizado com sucesso!' };
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Livro não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

// aqui serve para deletar os livros
router.delete('/:id', async (ctx) => {
  const { id } = ctx.params;
  try {
    const deleted = await db('livro').where({ id_livro: id }).del(); // importante passar o ID do livro
    if (deleted) {
      ctx.body = { message: 'Livro excluído com sucesso' };
    } else {
      ctx.status = 404;
      ctx.body = { message: 'Livro não encontrado' };
    }
  } catch (err) {
    ctx.status = 500;
    ctx.body = { message: err.message };
  }
});

module.exports = router;

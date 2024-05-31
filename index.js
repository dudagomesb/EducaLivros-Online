const Koa = require('koa');
const Router = require('koa-router');
const bodyParser = require('koa-bodyparser');

const userRoutes = require('./routes/userRoutes');
const bookRoutes = require('./routes/bookRoutes');
const loanRoutes = require('./routes/loanRoutes');

const app = new Koa();
const router = new Router();

app.use(bodyParser());

router.use('/users', userRoutes.routes());
router.use('/books', bookRoutes.routes());
router.use('/loans', loanRoutes.routes());

app.use(router.routes()).use(router.allowedMethods());

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

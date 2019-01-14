var express = require('express');
var router = express.Router();

const pages = {
  "starter_template" : {
    title: 'Bootstrap Starter Template'
  },
  "theme_example": {
    title: 'Theme Example',
    btn_size: ['lg', 'sm', 'xs'],
    btn_categories: ['Default', 'Primary', 'Success', 'Info', 'Warning', 'Danger']
  }
}

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', {
    title: 'Bootstrap Practice',
    pages: pages
  });
});

Object.keys(pages).forEach((key) => {
  let params = pages[key]

  router.get('/' + key, (req, res, next) => {
    res.render(key, params);
  });
})

module.exports = router;

Sephora México
==============

Proyecto para Sephora, escrito en Ruby con el framework Rails.

Para refrescar assets de paperclip correr:

    $ heroku run rake paperclip:refresh:missing_styles class=Producto
    $ heroku run rake assets:precompile
    $ heroku restart

Sephora México
==============

Proyecto para Sephora, escrito en Ruby con el framework Rails.

Para refrescar assets de paperclip correr:

    $ heroku run rake paperclip:refresh:missing_styles class=Producto
    $ heroku run rake assets:precompile
    $ heroku restart

Para refrescar un producto en específico:

    > Producto.find(id).foto.reprocess!

O con un loop para los productos con foto de una categoría específica:

    > Producto.find(:all, :conditions => ['marca_id = 52']).each do |r|
    >   unless r.foto_file_name == nil
    >     r.foto.reprocess!
    >   end
    > end

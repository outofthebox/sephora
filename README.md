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




Obtener Marcas sin Descripcion
> \copy (select m.id, m.marca as marca from marcas as m where m.descripcion is null) to  '[path]/marcas_sin_descripcion.cvs' DELIMITER ',' CSV HEADER;

Obtener Marcas sin Logo
> \copy (select m.id, m.marca as marca from marcas as m where m.logo_file_name is null) to  '[path]/marcas_sin_logo.cvs' DELIMITER ',' CSV HEADER

Obtener Productos sin Descripcion
> \copy (SELECT p.upc as upc, m.marca as marca, p.nombre from productos as p LEFT OUTER JOIN marcas as m on m.id = p.marca_id where p.descripcion IS NULL and p.publicado is TRUE) TO '[path]/productos_sin_descripcion.cvs' DELIMITER ',' CSV HEADER;

Obtener Productos sin Foto
> \copy (SELECT p.upc as upc, m.marca as marca, p.nombre from productos as p LEFT OUTER JOIN marcas as m on m.id = p.marca_id where p.foto_file_name IS NULL and p.publicado is TRUE) TO '[path]/productos_sin_foto.cvs' DELIMITER ',' CSV HEADER;

Obtener Productos sin Foto ni Descripcion

> \copy (SELECT p.upc as upc, m.marca as marca, p.nombre from productos as p LEFT OUTER JOIN marcas as m on m.id = p.marca_id where p.foto_file_name IS NULL and p.descripcion IS NULL and p.publicado is TRUE) TO '/Users/gessgallardo/Documents/sephora/queries/productos_sin_foto_ni_descripcion.cvs' DELIMITER ',' CSV HEADER;


## For Mobile V2
 
 rake db:migrate:down VERSION=20131001224
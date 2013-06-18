# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130618193545) do

  create_table "categoria_productos", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "categoria_id"
    t.integer  "orden"
    t.text     "descripcion"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "categoria_productos", ["categoria_id"], :name => "index_categoria_productos_on_categoria_id"
  add_index "categoria_productos", ["producto_id"], :name => "index_categoria_productos_on_producto_id"

  create_table "categorias", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.boolean  "visible"
    t.integer  "parent_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.text     "urlslug"
    t.text     "descripcion"
  end

  create_table "eventos", :force => true do |t|
    t.integer  "tienda"
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "fecha"
  end

  create_table "eventotiendas", :force => true do |t|
    t.string   "nombre"
    t.text     "horario"
    t.text     "descripcion"
    t.text     "informacion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "tienda_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.text     "comentario"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "marca_productos", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "marca_id"
    t.integer  "orden"
    t.text     "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "marca_productos", ["marca_id"], :name => "index_marca_productos_on_marca_id"
  add_index "marca_productos", ["producto_id"], :name => "index_marca_productos_on_producto_id"

  create_table "marcas", :force => true do |t|
    t.string   "marca"
    t.text     "descripcion"
    t.integer  "usuario_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "promo_file_name"
    t.string   "promo_content_type"
    t.integer  "promo_file_size"
    t.datetime "promo_updated_at"
    t.text     "behindthebrand"
    t.string   "video"
  end

  add_index "marcas", ["slug"], :name => "index_marcas_on_slug", :unique => true

  create_table "producto_secciones", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "seccion_id"
    t.integer  "orden"
    t.text     "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "producto_secciones", ["producto_id"], :name => "index_producto_secciones_on_producto_id"
  add_index "producto_secciones", ["seccion_id"], :name => "index_producto_secciones_on_seccion_id"

  create_table "productos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.decimal  "precio",            :precision => 10, :scale => 2
    t.boolean  "publicado",                                        :default => true
    t.text     "ingredientes"
    t.text     "usos"
    t.integer  "usuario_id"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.string   "slug"
    t.integer  "marca_id"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.string   "sku"
    t.text     "nombre_real"
    t.integer  "categoria_id"
    t.integer  "uso_id"
    t.integer  "parent_id"
    t.string   "upc"
  end

  add_index "productos", ["categoria_id"], :name => "index_productos_on_categoria_id"
  add_index "productos", ["marca_id"], :name => "index_productos_on_marca_id"
  add_index "productos", ["sku"], :name => "index_productos_on_sku"
  add_index "productos", ["slug"], :name => "index_productos_on_slug", :unique => true
  add_index "productos", ["upc"], :name => "index_productos_on_upc", :unique => true
  add_index "productos", ["uso_id"], :name => "index_productos_on_uso_id"

  create_table "registros", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.string   "cp"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "tienda"
    t.boolean  "qr",         :default => false
  end

  create_table "secciones", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.text     "descripcion"
    t.boolean  "visible"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "tiendas", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.string   "horario"
    t.string   "contacto"
    t.string   "direccion"
    t.string   "mapa"
    t.float    "latitud"
    t.float    "longitud"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  create_table "usos", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.boolean  "visible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "email",                  :default => "",        :null => false
    t.string   "encrypted_password",     :default => "",        :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "nombre"
    t.string   "rol",                    :default => "usuario"
    t.text     "meta"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "usuarios", ["authentication_token"], :name => "index_usuarios_on_authentication_token", :unique => true
  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["unlock_token"], :name => "index_usuarios_on_unlock_token", :unique => true

end

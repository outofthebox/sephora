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

ActiveRecord::Schema.define(:version => 20161101062728) do

  create_table "banners", :force => true do |t|
    t.boolean  "pinned"
    t.date     "valid_from"
    t.date     "valid_to"
    t.integer  "priority"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "link"
  end

  create_table "blog_categorias", :force => true do |t|
    t.string   "categoria"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blog_users", :force => true do |t|
    t.string   "nickname"
    t.string   "nombre"
    t.string   "correo"
    t.string   "password",          :limit => 10000
    t.text     "fb_token"
    t.text     "tw_token"
    t.text     "tw_secret"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

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

  create_table "comments", :force => true do |t|
    t.integer  "padre"
    t.text     "comentario"
    t.boolean  "publicado",  :default => false
    t.integer  "post_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.text     "comentario"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "landings", :force => true do |t|
    t.integer  "marca_id"
    t.string   "link"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
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
    t.integer  "vista"
  end

  add_index "marcas", ["slug"], :name => "index_marcas_on_slug", :unique => true

  create_table "media_tags", :force => true do |t|
    t.string   "instagram_id"
    t.string   "instagram_link"
    t.string   "thumb_url"
    t.string   "pic_url"
    t.string   "video_url"
    t.string   "fullname"
    t.string   "username"
    t.boolean  "approved",       :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "mobileusers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "favoritos",              :default => ""
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "mobileusers", ["email"], :name => "index_mobileusers_on_email", :unique => true
  add_index "mobileusers", ["reset_password_token"], :name => "index_mobileusers_on_reset_password_token", :unique => true

  create_table "models", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "mobilelogin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "models", ["email"], :name => "index_models_on_email", :unique => true
  add_index "models", ["reset_password_token"], :name => "index_models_on_reset_password_token", :unique => true

  create_table "post_favs", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "slug"
    t.text     "content"
    t.text     "extracto"
    t.integer  "visitas"
    t.integer  "categoria_id"
    t.boolean  "publicado",           :default => true
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

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
    t.decimal  "precio",               :precision => 10, :scale => 2
    t.boolean  "publicado",                                           :default => true
    t.text     "ingredientes"
    t.text     "usos"
    t.integer  "usuario_id"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
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
    t.string   "image_code"
    t.string   "personalidad"
    t.integer  "visto",                                               :default => 0
    t.decimal  "descuento"
    t.string   "sap"
    t.integer  "descuento_porcentual",                                :default => 0
  end

  add_index "productos", ["categoria_id"], :name => "index_productos_on_categoria_id"
  add_index "productos", ["marca_id"], :name => "index_productos_on_marca_id"
  add_index "productos", ["sku"], :name => "index_productos_on_sku"
  add_index "productos", ["slug"], :name => "index_productos_on_slug", :unique => true
  add_index "productos", ["upc"], :name => "index_productos_on_upc", :unique => true
  add_index "productos", ["uso_id"], :name => "index_productos_on_uso_id"

  create_table "productos_usuarios", :id => false, :force => true do |t|
    t.integer "usuario_id"
    t.integer "producto_id"
  end

  add_index "productos_usuarios", ["producto_id"], :name => "index_productos_usuarios_on_producto_id"
  add_index "productos_usuarios", ["usuario_id"], :name => "index_productos_usuarios_on_usuario_id"

  create_table "rankings", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "post_id"
    t.integer  "raiting"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "redactor_assets", :force => true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  create_table "redemptions", :force => true do |t|
    t.string   "code"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "sephoragrams", :force => true do |t|
    t.string   "instagram_id"
    t.string   "instagram_link"
    t.string   "pic_thumb"
    t.string   "pic_med"
    t.string   "pic_large"
    t.string   "fullname"
    t.string   "username"
    t.boolean  "publicado",      :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "store_events", :force => true do |t|
    t.integer  "tienda_id"
    t.integer  "event_id"
    t.string   "link"
    t.string   "dates"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "store_events", ["event_id"], :name => "index_store_events_on_event_id"
  add_index "store_events", ["tienda_id"], :name => "index_store_events_on_tienda_id"

  create_table "store_has_events", :force => true do |t|
    t.integer  "tienda_id"
    t.string   "dates"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

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
    t.string   "map"
  end

  create_table "tips", :force => true do |t|
    t.string   "nombre"
    t.string   "correo"
    t.text     "tip"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  create_table "uploads", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_posts", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "post_id"
    t.integer  "raiting"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "userwishes", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "post_id"
    t.string   "access_token"
  end

  create_table "usos", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.boolean  "visible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "usuario_trivia", :force => true do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "ticket"
    t.string   "correo"
    t.string   "telefono"
    t.text     "respuestas"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "start_at"
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
    t.string   "apellido"
    t.date     "cumple"
    t.string   "cp"
  end

  add_index "usuarios", ["authentication_token"], :name => "index_usuarios_on_authentication_token", :unique => true
  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["unlock_token"], :name => "index_usuarios_on_unlock_token", :unique => true

  create_table "wishlists", :id => false, :force => true do |t|
    t.integer  "userwish_id"
    t.integer  "producto_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end

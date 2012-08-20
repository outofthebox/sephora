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

ActiveRecord::Schema.define(:version => 20120820161510) do

  create_table "categorias", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.boolean  "visible"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "marcas", :force => true do |t|
    t.string   "marca"
    t.text     "descripcion"
    t.integer  "usuario_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "marcas", ["slug"], :name => "index_marcas_on_slug", :unique => true

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
  end

  add_index "productos", ["categoria_id"], :name => "index_productos_on_categoria_id"
  add_index "productos", ["marca_id"], :name => "index_productos_on_marca_id"
  add_index "productos", ["sku"], :name => "index_productos_on_sku", :unique => true
  add_index "productos", ["slug"], :name => "index_productos_on_slug", :unique => true
  add_index "productos", ["uso_id"], :name => "index_productos_on_uso_id"

  create_table "usos", :force => true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.boolean  "visible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

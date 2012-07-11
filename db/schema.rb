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

ActiveRecord::Schema.define(:version => 20120711172010) do

  create_table "marcas", :force => true do |t|
    t.string   "marca"
    t.text     "descripcion"
    t.integer  "usuario_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "productos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.decimal  "precio",       :precision => 10, :scale => 2
    t.boolean  "publicado",                                   :default => true
    t.text     "ingredientes"
    t.text     "usos"
    t.integer  "usuario_id"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

end

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

ActiveRecord::Schema.define(:version => 20121003133718) do

  create_table "CP_BUSINESS", :primary_key => "ID", :force => true do |t|
    t.integer   "CPID"
    t.integer   "SPID"
    t.string    "BUSINESSID",    :limit => 10,                  :null => false
    t.string    "CMD",           :limit => 20
    t.integer   "CMDTYPE"
    t.float     "PAYPRCT",       :limit => 3
    t.integer   "DISCOUNTPRCT"
    t.integer   "STATUS",                       :default => 0
    t.timestamp "CREATETIME",                                   :null => false
    t.string    "INTERFACEURL",  :limit => 100
    t.string    "REPORTVALID",   :limit => 30,  :default => ""
    t.integer   "REQUESTMETHOD",                :default => 0
    t.string    "URLTEMPLATE",   :limit => 200, :default => ""
  end

  create_table "CP_INFO", :primary_key => "CPID", :force => true do |t|
    t.string    "CPNAME",        :limit => 20
    t.string    "LOGINNAME",     :limit => 20
    t.string    "LOGINPASSWORD", :limit => 20,                :null => false
    t.integer   "LOGINCOUNT",                  :default => 0
    t.string    "LASTLOGINIP",   :limit => 20
    t.integer   "STATUS",                      :default => 0
    t.integer   "CREATEUSERID"
    t.timestamp "CREATETIME",                                 :null => false
  end

  create_table "SP_ACCOUNT", :primary_key => "USERID", :force => true do |t|
    t.string  "USERNAME",      :limit => 20
    t.string  "PASSWORD",      :limit => 20, :null => false
    t.string  "MENULIST",      :limit => 20
    t.string  "NOTE",          :limit => 80
    t.date    "LASTLOGINTIME"
    t.string  "LASTLOGINIP",   :limit => 20
    t.integer "LOGINCOUNT"
    t.integer "STATUS"
  end

  create_table "SP_ALERT", :primary_key => "ID", :force => true do |t|
    t.integer   "SEVERITY"
    t.string    "NOTE",       :limit => 50
    t.string    "DETAIL",     :limit => 500
    t.timestamp "CREATETIME",                :null => false
  end

  create_table "SP_BUSINESS", :primary_key => "ID", :force => true do |t|
    t.integer   "SPID"
    t.string    "BUSINESSID",   :limit => 10,                  :null => false
    t.string    "SPNUMBER",     :limit => 15
    t.string    "CMD",          :limit => 30,                  :null => false
    t.float     "PRICE",        :limit => 4
    t.integer   "CMDTYPE"
    t.integer   "ISASSIGN",                     :default => 0
    t.integer   "STATUS",                                      :null => false
    t.string    "AREALIST",     :limit => 1000
    t.timestamp "CREATETIME",                                  :null => false
    t.integer   "BUSINESSTYPE",                 :default => 0, :null => false
  end

  create_table "SP_INFO", :id => false, :force => true do |t|
    t.integer   "SPID",                                        :null => false
    t.string    "SPNAME",        :limit => 20
    t.integer   "PAYPERIOD"
    t.integer   "PAYPERIODTYPE"
    t.integer   "PAYPRCT"
    t.string    "MOREQSUFFIX",   :limit => 100
    t.string    "MOREQPRAMLIST", :limit => 100
    t.string    "MRREQSUFFIX",   :limit => 100
    t.string    "MRREQPRAMLIST", :limit => 100
    t.timestamp "CREATETIME",                                  :null => false
    t.integer   "STATUS",                       :default => 0
    t.integer   "ACCEPTTYPE",                                  :null => false
    t.integer   "CATAGORY",                                    :null => false
  end

  add_index "sp_info", ["SPID"], :name => "SPID"

  create_table "SP_IVRLOG", :primary_key => "ID", :force => true do |t|
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10,                :null => false
    t.integer   "CPID"
    t.string    "PHONENUMBER", :limit => 11,                :null => false
    t.string    "LINKID",      :limit => 50,                :null => false
    t.string    "STATUS",      :limit => 50,                :null => false
    t.integer   "ISDISCOUNT"
    t.integer   "VALID",                     :default => 1
    t.datetime  "STARTTIME"
    t.datetime  "ENDTIME"
    t.integer   "TIMELENGTH"
    t.integer   "FEE"
    t.timestamp "CREATETIME",                               :null => false
  end

  create_table "SP_MOLOG", :primary_key => "ID", :force => true do |t|
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10,  :null => false
    t.integer   "CPID"
    t.string    "CONTENT",     :limit => 100
    t.string    "SPNUMBER",    :limit => 50,  :null => false
    t.string    "LINKID",      :limit => 50,  :null => false
    t.string    "PHONENUMBER", :limit => 11
    t.timestamp "CREATETIME",                 :null => false
    t.string    "TELESEG",     :limit => 7
  end

  add_index "sp_molog", ["CREATETIME"], :name => "INX_SP_MOLOG_CREATETIME"
  add_index "sp_molog", ["LINKID"], :name => "IDX_SP_MOLOG_LINKID"
  add_index "sp_molog", ["TELESEG"], :name => "idx_teleseg_sp_molog"
  add_index "sp_molog", ["TELESEG"], :name => "idx_teleseg_sp_mrlog"

  create_table "SP_MRLOG", :primary_key => "ID", :force => true do |t|
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10,                :null => false
    t.integer   "CPID"
    t.string    "PHONENUMBER", :limit => 11,                :null => false
    t.string    "LINKID",      :limit => 50,                :null => false
    t.string    "STATUS",      :limit => 50,                :null => false
    t.integer   "ISDISCOUNT"
    t.timestamp "CREATETIME",                               :null => false
    t.integer   "VALID",                     :default => 1
    t.string    "TELESEG",     :limit => 7
  end

  add_index "sp_mrlog", ["LINKID"], :name => "IDX_SP_MRLOG_LINKID"

  create_table "SP_REPORT", :primary_key => "ID", :force => true do |t|
    t.integer  "CPID"
    t.integer  "SPID"
    t.string   "BUSINESSID",    :limit => 10
    t.integer  "COUNT"
    t.integer  "VALIDCOUNT"
    t.datetime "FIRSTSTATTIME",               :null => false
    t.datetime "LASTSTATTIME",                :null => false
    t.date     "STATDATE"
  end

  add_index "sp_report", ["CPID", "SPID", "BUSINESSID"], :name => "IDX_SP_REPORT_STATDATE_CPID_SPID_BUSINESSID"

  create_table "SP_ROUTER", :id => false, :force => true do |t|
    t.string   "TELSEG",     :limit => 7
    t.string   "AREACODE",   :limit => 6
    t.datetime "CREATETIME"
    t.string   "CITY",       :limit => 40
    t.string   "PROVINCE",   :limit => 40
    t.string   "ZIP",        :limit => 10
  end

  add_index "sp_router", ["TELSEG"], :name => "SP_ROUTE_TEL_IDX"

  create_table "SP_URLLOG", :primary_key => "ID", :force => true do |t|
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10
    t.integer   "CPID"
    t.string    "URL",         :limit => 500
    t.integer   "REQTYPE",                    :null => false
    t.date      "RECEIVETIME"
    t.timestamp "CREATETIME",                 :null => false
  end

  create_table "admins", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "cp_businesses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cp_infos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mr_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "type"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sp_alerts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sp_businesses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sp_infos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sp_routers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "roleid"
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

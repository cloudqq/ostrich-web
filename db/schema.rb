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

ActiveRecord::Schema.define(:version => 20131203134157) do

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

  create_table "SERIALS", :force => true do |t|
    t.string   "CODE",                      :null => false
    t.integer  "MAXNO",      :default => 0
    t.integer  "LENGTH",     :default => 2
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
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
    t.string    "SPNUMBER",     :limit => 25
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

  create_table "rest", :id => false, :force => true do |t|
    t.integer "spid"
    t.string  "businessid",  :limit => 10,                 :null => false
    t.integer "cpid"
    t.string  "content",     :limit => 100
    t.string  "spnumber",    :limit => 50,                 :null => false
    t.string  "phonenumber", :limit => 11
    t.string  "status",      :limit => 50,                 :null => false
    t.integer "valid",                      :default => 1
    t.integer "isdiscount"
  end

  create_table "roles", :force => true do |t|
    t.integer  "type"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sample", :id => false, :force => true do |t|
    t.string "phone", :limit => 13
  end

  add_index "sample", ["phone"], :name => "sample_phone"

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

  create_table "spc_001_mo", :id => false, :force => true do |t|
    t.string    "linkid",    :limit => 100
    t.integer   "motype"
    t.string    "spcode",    :limit => 10
    t.string    "mobile",    :limit => 12
    t.string    "content",   :limit => 20
    t.integer   "feeprice"
    t.integer   "feetype"
    t.datetime  "motime"
    t.datetime  "update_at"
    t.timestamp "create_at",                :null => false
  end

  create_table "spc_001_mr", :id => false, :force => true do |t|
    t.string    "msgid",       :limit => 100
    t.string    "linkid",      :limit => 100
    t.string    "status",      :limit => 20
    t.string    "mobile",      :limit => 12
    t.integer   "price"
    t.integer   "feetype"
    t.integer   "continued"
    t.datetime  "create_date"
    t.datetime  "update_at"
    t.timestamp "create_at",                  :null => false
  end

  add_index "spc_001_mr", ["msgid"], :name => "idx_spc_mr"

  create_table "stat_7", :id => false, :force => true do |t|
    t.integer   "ID",                         :default => 0, :null => false
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10,                 :null => false
    t.integer   "CPID"
    t.string    "CONTENT",     :limit => 100
    t.string    "SPNUMBER",    :limit => 50,                 :null => false
    t.string    "LINKID",      :limit => 50,                 :null => false
    t.string    "PHONENUMBER", :limit => 11
    t.timestamp "CREATETIME",                                :null => false
    t.string    "TELESEG",     :limit => 7
  end

  add_index "stat_7", ["CREATETIME"], :name => "stat_7_createtime"
  add_index "stat_7", ["LINKID"], :name => "idx_stat_linkid"
  add_index "stat_7", ["PHONENUMBER"], :name => "idx_stat_phone"

  create_table "stat_mr7", :id => false, :force => true do |t|
    t.integer   "ID",                        :default => 0, :null => false
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

  add_index "stat_mr7", ["CREATETIME"], :name => "stat_mr7_createtime"
  add_index "stat_mr7", ["LINKID"], :name => "idx_stat_mr_linkid"
  add_index "stat_mr7", ["PHONENUMBER"], :name => "idx_stat_mr_phone"

  create_table "tmp1", :id => false, :force => true do |t|
    t.string "phone", :limit => 12
  end

  add_index "tmp1", ["phone"], :name => "idx_tmp_phone"

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

  create_table "xt_mon_1_3", :id => false, :force => true do |t|
    t.integer   "ID",                         :default => 0, :null => false
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10,                 :null => false
    t.integer   "CPID"
    t.string    "CONTENT",     :limit => 100
    t.string    "SPNUMBER",    :limit => 50,                 :null => false
    t.string    "LINKID",      :limit => 50,                 :null => false
    t.string    "PHONENUMBER", :limit => 11
    t.timestamp "CREATETIME",                                :null => false
    t.string    "TELESEG",     :limit => 7
  end

  create_table "xt_mon_1_3_phone", :id => false, :force => true do |t|
    t.integer   "ID",                         :default => 0, :null => false
    t.integer   "SPID"
    t.string    "BUSINESSID",  :limit => 10,                 :null => false
    t.integer   "CPID"
    t.string    "CONTENT",     :limit => 100
    t.string    "SPNUMBER",    :limit => 50,                 :null => false
    t.string    "LINKID",      :limit => 50,                 :null => false
    t.string    "PHONENUMBER", :limit => 11
    t.timestamp "CREATETIME",                                :null => false
    t.string    "TELESEG",     :limit => 7
  end

  create_table "xt_mon_1_3_phone_list", :id => false, :force => true do |t|
    t.string  "phonenumber", :limit => 11
    t.integer "count(1)",    :limit => 8,  :default => 0, :null => false
  end

end

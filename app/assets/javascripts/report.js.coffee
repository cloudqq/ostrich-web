# encoding: utf-8
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@search_today = ->
  today = new Date()
  nextday = new Date()
  nextday.setDate(nextday.getDate() + 1)

  sdate = today.getFullYear() + '-' + (today.getMonth()+1) + '-' + today.getDate();
  edate = nextday.getFullYear() + '-' + (nextday.getMonth()+1) + '-' + nextday.getDate();

  params = []
  var_cpname = $("#input_cpname").val()
  var_spname = $("#input_spname").val()

  if var_cpname != undefined
    params.push( { name: "cpname", value: var_cpname })
  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })
    
  params.push( { name: "sdate", value: sdate })
  params.push( { name: "edate", value: edate })

  list_report_stat_table(params)        

@search = ->
  params = []
  var_cpname = $("#input_cpname").val()
  var_spname = $("#input_spname").val()
  var_start_date = $("#input_start_date").val()
  var_end_date = $("#input_end_date").val()

  if var_cpname != undefined
    params.push( { name: "cpname", value: var_cpname })
  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })
  if var_start_date != undefined && var_end_date != undefined
    params.push( { name: "sdate", value: var_start_date })
    params.push( { name: "edate", value: var_end_date})

  list_report_stat_table(params)    

# 每日统计报表
@list_report_stat_table = (server_params) ->
  params =
    sNewLine: "<br>"
    sButtonText: "Copy to element"
    sDiv: ""
    fnClick: (nButton, oConfig) ->
      $(window).attr("location", "/cp_business/create")
                
  TableTools.BUTTONS.create_new_cp_business_div = $.extend true, TableTools.buttonBase, params
  
  options =
    column_names: ["统计日期","SPID","SP名称","CPID","CP名词","接收数量","单价","同步数据","同步金额","扣量"]
    url: "/report/list_stat_for_table.json"
    paging: true
    server_params: server_params
  adv_options =
    aLengthMenu: [10,25,50]
    oTableTools:
      aButtons: [
        sExtends: "create_new_cp_business_div"
        sButtonText: "新建"
        sDiv: "copy"
      ]
    aoColumnDefs:[
      {
        sWidth:"5%"
        aTargets:[0]
      },
      {
        sWidth:"4%"
        aTargets:[1]
      }
    ]
        
  $("#tb_report_stat_table").easyTable options, adv_options

@search_detail = ->
  params = []
  var_cpname = $("#input_cpname").val()
  var_spname = $("#input_spname").val()
  var_date = $("#input_date").val()
  var_phone = $("#input_phone").val()

  if var_cpname != undefined
    params.push( { name: "cpname", value: var_cpname })
  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })
  if var_date != undefined && var_date != undefined
    params.push( { name: "date", value: var_date})
  if var_phone != undefined
    params.push( {name: "phone", value: var_phone})

  list_report_detail_table(params)    

# 明细查询报表
@list_report_detail_table = (server_params) ->
  options =
    column_names: ["上行时间","手机号码","内容","LINKID","SP","CP","状态","扣量"]
    url: "/report/list_detail_for_table.json"
    paging: true
    server_params: server_params
    dom:'<"clear">tlpi'
  adv_options =
    aLengthMenu: [10,25,50]
    aoColumnDefs:[
      {
        sWidth:"14%"
        aTargets:[0]
      },
      {
        sWidth:"10%"
        aTargets:[1]
      },
      {
        sWidth:"10%"
        aTargets:[2]
      },
      {
        sWidth:"16%"
        aTargets:[3]
      },
      {
        sWidth:"10%"
        aTargets:[4]
      },
      {
        sWidth:"10%"
        aTargets:[5]
      },
      {
        sWidth:"10%"
        aTargets:[6]
      },
      {
        sWidth:"10%"
        aTargets:[7]
      },                         
      
    ]
    aoColumns:[
      {
        mData: "createtime"
        aTargets:[0]
      },
      {
        mData: "phonenumber"
        aTargets:[1]
      },
      {
        mData: "content"
        aTargets:[2]
      },
      {
        mData: "linkid"
        aTargets:[3]
      },
      {
        mData: "spname"
        aTargets:[4]
      },
      {
        mData: "cpname"
        aTargets:[5]
      },
      {
        mData: "status"
        aTargets:[6]
      },
      {
        mData: "discount"
        aTargets:[7]
      }
    ]
        
  $("#tb_report_detail_table").easyTable options, adv_options

  

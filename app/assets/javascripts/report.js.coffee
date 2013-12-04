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

  

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
  var_spnumber = $("#input_spnumber").val()
  var_cmd = $("#input_cmd").val()
  var_start_date = $("#input_start_date").val()
  var_end_date = $("#input_end_date").val()
  
  if var_cpname != undefined
    params.push( { name: "cpname", value: var_cpname })
  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })
  if var_spnumber != undefined
    params.push( { name: "spnumber", value: var_spnumber})
  if var_cmd != undefined
    params.push( { name: "cmd", value: var_cmd })
  
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
    column_names: ["统计日期","SP名称","CP名词","特服号","指令","MO","MR","省份控制","扣量","成功","转发"]
    url: "/report/list_stat_for_table.json"
    paging: true
    server_params: server_params
  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false
    oTableTools:
      aButtons: [
        sExtends: "create_new_cp_business_div"
        sButtonText: "新建"
        sDiv: "copy"
      ]
    aoColumns:[
      {
        aTargets:[0]
        mData: 'statdate'
      },
      {
        aTargets:[1]
        mData: 'spname'
      },
      {
        aTargets:[2]
        mData: 'cpname'
      },
      {
        aTargets:[3]
        mData: 'spnumber'  
      },
      {
        aTargets:[4]
        mData: 'cmd'
      },
      {
        aTargets:[5]
        mData: 'mo_count'
      },
      {
        aTargets:[6]
        mData: 'mr_count'
      },
      {
        aTargets:[7]
        mData: 'forward'
      },
      {
        aTargets:[8]
        mData: 'discount'
      },
      {
        aTargets:[9]
        mData: 'delivrd'
      },
      {
        aTargets:[10]
        mData: 'dispatch'
      }      

    ]
    aoColumnDefs:[
      {
        sWidth:"10%"
        aTargets:[0]
      },
      {
        sWidth:"15%"
        aTargets:[1]
      },
      {
        sWidth:"12%"
        aTargets:[2]
      },
      {
        sWidth:"10%"
        aTargets:[3]
      },            
      
    ]
        
  $("#tb_report_stat_table").easyTable options, adv_options

@search_detail = ->
  params = []
  var_cpname = $("#input_cpname").val()
  var_spname = $("#input_spname").val()
  var_date = $("#input_date").val()
  var_phone = $("#input_phone").val()
  var_cmd = $("#input_cmd").val()

  if var_cpname != undefined
    params.push( { name: "cpname", value: var_cpname })
  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })
  if var_date != undefined && var_date != undefined
    params.push( { name: "date", value: var_date})
  if var_phone != undefined
    params.push( {name: "phone", value: var_phone})
  if var_cmd != undefined
    params.push( {name:"cmd",value: var_cmd})

  list_report_detail_table(params)    

# 明细查询报表
@list_report_detail_table = (server_params) ->
  options =
    column_names: ["上行时间","手机号码","内容","省市", "LINKID","SP","CP","状态","扣","屏","转"]
    url: "/report/list_detail_for_table.json"
    paging: true
    server_params: server_params
    dom:'<"clear">tlpi'
  adv_options =
    aLengthMenu: [10,25,50]
    bSort: false    
    aoColumnDefs:[
      {
        sWidth:"18%"
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
        sWidth:"12%"
        aTargets:[3]
        mRender:(data,type,row) ->
          """
            #{data.province} #{data.city}
          """
      },
      {
        sWidth:"10%"
        aTargets:[4]
      },
      {
        sWidth:"8%"
        aTargets:[5]
      },
      {
        sWidth:"8%"
        aTargets:[6]
      },
      {
        sWidth:"8%"
        aTargets:[7]
      },
      {
        sWidth:"6%"
        aTargets:[8]
        mRender: (data,type,row) ->
          if data == 1
            "是"
          else
            "否"
      },
      {
        sWidth:"6%"
        aTargets:[9]
        mRender: (data,type,row) ->
          if data == 1
            "否"
          else
            "是"
      },
      {
        sWidth:"10%"
        aTargets:[10]
        mRender: (data,type,row) ->
          if data == 1
            "是"
          else
            "否"          
      }
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
        mData: (source,type,val) ->
          {
            province: source.province,
            city: source.city
          }
        aTargets:[3]
      },
      {
        mData: "linkid"
        aTargets:[4]
      },
      {
        mData: "spname"
        aTargets:[5]
      },
      {
        mData: "cpname"
        aTargets:[6]
      },
      {
        mData: "status"
        aTargets:[7]
      },
      {
        mData: "discount"
        aTargets:[8]
      },
      {
        mData: "forward"
        aTargets:[9]
      },
      {
        mData: "dispatch"
        aTargets:[10]
      }                  
    ]
        
  $("#tb_report_detail_table").easyTable options, adv_options



@province_status_search_yestory = ->
  today = new Date()
  nextday = new Date()
  nextday.setDate(nextday.getDate() - 1)
  edate = nextday.getFullYear() + '-' + (nextday.getMonth()+1) + '-' + nextday.getDate();  
  $("#input_date").val(edate)
  province_status_search()

@province_status_search = ->
  params = []
  var_cpname = $("#input_cpname").val()
  var_spname = $("#input_spname").val()
  var_date = $("#input_date").val()
  var_spnumber = $("#input_spnumber").val()
  var_cmd = $("#input_cmd").val()
  var_province = $("#input_province").val()

  if var_cpname != undefined
    params.push( { name: "cpname", value: var_cpname })
  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })
  if var_date != undefined && var_date != undefined
    params.push( { name: "date", value: var_date})
  if var_cmd != undefined
    params.push( {name:"cmd",value: var_cmd})
  if var_spnumber != undefined
    params.push( {name:"spnumber", value:var_spnumber})
  if var_province != undefined
    params.push({name:"province", value:var_province})

  load_province_status_table(params)    
  

# 查询省份情况
@load_province_status_table = (server_params) ->
  options =
    column_names: ["省份","CPID","SPID","特服号", "指令","MO","屏蔽","扣量","转发"]
    url: "/report/province_status_for_table.json"
    paging: true
    server_params: server_params
    dom:'<"clear">tlpi'
  adv_options =
    aLengthMenu: [10,25,50]
    bSort: false    
    aoColumnDefs:[
      {
        sWidth:"10%"
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
        sWidth:"12%"
        aTargets:[3]
      },
      {
        sWidth:"10%"
        aTargets:[4]
      },
      {
        sWidth:"8%"
        aTargets:[5]
      },
      {
        sWidth:"8%"
        aTargets:[6]
      },
      {
        sWidth:"8%"
        aTargets:[7]
      },
      {
        sWidth:"6%"
        aTargets:[8]
      }
    ]
    aoColumns:[
      {
        mData: "province"
        aTargets:[0]
      },
      {
        mData: "cpname"
        aTargets:[1]
      },
      {
        mData: "spname"
        aTargets:[2]
      },
      {
        aTargets:[3]
        mData: "spnumber"
      },
      {
        mData: "cmd"
        aTargets:[4]
      },
      {
        mData: "mo_count"
        aTargets:[5]
      },
      {
        mData: "not_forward"
        aTargets:[6]
      },
      {
        mData: "discount"
        aTargets:[7]
      },
      {
        mData: "dispatched"
        aTargets:[8]
      }
    ]
        
  $("#tb_province_status_table").easyTable options, adv_options

  
